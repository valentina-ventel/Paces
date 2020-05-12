//
//  LoginViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 01/05/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func facebookLogin(_ sender: AnyObject) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
               if let error = error {
                   print("Failed to login: \(error.localizedDescription)")
                   return
               }
               
               guard let accessToken = AccessToken.current else {
                   print("Failed to get access token")
                   return
               }
        
               let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
               
               // Perform login by calling Firebase APIs
                Auth.auth().signIn(with: credential) { (user, error) in
                  if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                  }
                    NotificationCenter.default.post(name: .loginSuccessful, object: nil)
                    //self.dismiss(animated: true, completion: nil)
                }
            
                if let currentUser = Auth.auth().currentUser {
                    print("----------**********--------------")
                    print("Oleeeeeeeee")
                    print(currentUser.displayName)
                }
           }
    }
}

extension Notification.Name {
    static let loginSuccessful = Notification.Name("loginSuccessful")
}
