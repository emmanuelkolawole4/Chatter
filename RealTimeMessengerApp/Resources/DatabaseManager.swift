//
//  DatabaseManager.swift
//  RealTimeMessengerApp
//
//  Created by FOLAHANMI KOLAWOLE on 27/01/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

// MARK: - Account Management
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { dataSnapShot in
            guard dataSnapShot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// public function (api endpoint) exposed so that users can be inserted into firebase realtime database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue(["first_name": user.firstName, "last_name": user.lastName])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}
