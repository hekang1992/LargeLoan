//
//  LocationManager.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/29.
//

import UIKit
import RxSwift
import RxRelay
import CoreLocation

class LocationManager: NSObject {
    
    let disposeBag = DisposeBag()
    
    var locationMan = CLLocationManager()
    
    var completion: ((LoactioModel) -> Void)?
    
    var model = BehaviorRelay<LoactioModel?>(value: nil)
    
    override init() {
        super.init()
        locationMan.delegate = self
        
        locationMan.desiredAccuracy = kCLLocationAccuracyBest
        
        model.asObservable()
            .debounce(RxTimeInterval.milliseconds(500),
                       scheduler: MainScheduler.instance)
            .distinctUntilChanged()
           .subscribe(onNext: { locationModel in
                if let locationModel = locationModel {
                    self.completion?(locationModel)
                }
            }).disposed(by: disposeBag)
        
    }
    
}


extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationMan.startUpdatingLocation()
        case .denied, .restricted:
            let model = LoactioModel()
            self.model.accept(model)
            locationMan.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func requestLoaction(completion: @escaping (LoactioModel) -> Void) {
        self.completion = completion
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let status: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                status = CLLocationManager().authorizationStatus
            } else {
                status = CLLocationManager.authorizationStatus()
            }
            if status == .notDetermined {
                locationMan.requestAlwaysAuthorization()
                locationMan.requestWhenInUseAuthorization()
            }else if status == .denied || status == .restricted {
                let lmodel = LoactioModel()
                self.model.accept(lmodel)
            }else {
                locationMan.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let model = LoactioModel()
        model.opportunity = location.coordinate.longitude
        model.take = location.coordinate.latitude
        
        let geocoder = CLGeocoder()
        let lion = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        geocoder.reverseGeocodeLocation(lion) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found.")
                return
            }
            self.populateLocationModel(model, with: placemark)
            self.model.accept(model)
            self.locationMan.stopUpdatingLocation()
        }
    }
    
    // 提取方法用于填充地理信息
    private func populateLocationModel(_ model: LoactioModel, with placemark: CLPlacemark) {
        model.training = placemark.locality ?? ""
        model.revenge = (placemark.subLocality ?? "") + (placemark.thoroughfare ?? "")
        model.five = placemark.country ?? ""
        model.thousand = placemark.isoCountryCode ?? ""
        model.hide = placemark.administrativeArea ?? ""
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}


class LoactioModel: Codable, Equatable {
    var hide: String = ""
    var thousand: String = ""
    var five: String = ""
    var revenge: String = ""
    var take: Double = 0.00000
    var opportunity: Double = 0.00000
    var training: String = ""
    
    enum CodingKeys: String, CodingKey {
        case hide = "hide"
        case thousand = "thousand"
        case five = "five"
        case revenge = "revenge"
        case take = "take"
        case opportunity = "opportunity"
        case training = "training"
    }
    
    static func == (lhs: LoactioModel, rhs: LoactioModel) -> Bool {
        return lhs.hide == rhs.hide &&
        lhs.thousand == rhs.thousand &&
        lhs.five == rhs.five &&
        lhs.revenge == rhs.revenge &&
        lhs.take == rhs.take &&
        lhs.opportunity == rhs.opportunity &&
        lhs.training == rhs.training
    }
    
}
