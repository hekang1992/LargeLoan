//
//  ContactManager.swift
//  LargeLoan
//
//  Created by TRUMP on 2024/12/26.
//

import Contacts

class ContactManager {
    let contactStore = CNContactStore()
    
    func requestAccess(completion: @escaping (Bool, Error?) -> Void) {
        contactStore.requestAccess(for: .contacts) { granted, error in
            completion(granted, error)
        }
    }
    
    func fetchContacts() -> [CNContact] {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        var contacts: [CNContact] = []
        
        do {
            try contactStore.enumerateContacts(with: fetchRequest) { contact, stop in
                contacts.append(contact)
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
        
        return contacts
    }
}

