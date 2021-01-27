//
//  ViewController.swift
//  RealTimeMessengerApp
//
//  Created by FOLAHANMI KOLAWOLE on 07/01/2021.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        DatabaseManager.shared.userExists(with: "emmanuelkolawole4@gmail.com") { (exists) in
            guard !exists else {
                print("this user exists")
                return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    // check if user has been previously logged in. if not, show the login view controller
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let nc = UINavigationController(rootViewController: LoginViewController())
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: false)
        }
    }

}

