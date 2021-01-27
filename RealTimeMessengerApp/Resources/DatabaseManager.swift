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
        database.child(email).observeSingleEvent(of: .value) { (dataSnapShot) in
            completion(false)
            guard dataSnapShot.value as? String != nil else { return }
        }
        completion(true)
    }
    
    /// public api endpoint exposed so that users can be inserted into firebase realtime database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue(["first_name": user.firstName, "last_name": user.lastName])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
}
