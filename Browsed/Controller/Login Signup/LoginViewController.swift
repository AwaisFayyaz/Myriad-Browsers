//
//  LoginViewController.swift
//  Myriad
//
//  Created by MacBook on 2/3/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import UIKit
import FirebaseAuth
import  Firebase
//import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
        
    }
    
    private func setupViews(){
        self.navigationController?.isNavigationBarHidden = false
        Auth.auth().addStateDidChangeListener() { auth, user in
          if user != nil {
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! ViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
            
//            self.performSegue(withIdentifier: self.loginToList, sender: nil)
            self.textFieldLoginEmail.text = nil
            self.textFieldLoginPassword.text = nil
          }
        }
        
//        let ref = Database.database().reference()
//        ref.child("users").setValue("Hamza Amin")
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard
          let email = textFieldLoginEmail.text,
          let password = textFieldLoginPassword.text,
          email.count > 0,
          password.count > 0
          else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
          if let error = error, user == nil {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true, completion: nil)
          }
        }
        
            //1. Create the alert controller.
//            let alert = UIAlertController(title: "Success", message: "You are successfully logged in to Myriad", preferredStyle: .alert)
//
//
//            let okBtn = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//
//                let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! ViewController
//                self.navigationController?.pushViewController(homeVC, animated: true)
//
//            })
//            alert.addAction(okBtn)
//            self.present(alert, animated: true, completion: nil)
    
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        
//      let alert = UIAlertController(title: "Register",
//                                    message: "Register",
//                                    preferredStyle: .alert)
//
//      let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//
//        let fullNameField = alert.textFields![0]
//        let emailField = alert.textFields![1]
//        let passwordField = alert.textFields![2]
////
//
//        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
//          if error == nil {
//            Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
//                               password: self.textFieldLoginPassword.text!)
//            let userObject = [
//                "id": user?.user.uid,
//                "name": fullNameField.text,
//               "password": passwordField.text, // I don't recommend storing passwords like this by the way
//                "email": emailField.text
//            ] as [String:Any]
//            let ref = Database.database().reference()
//            ref.child("users").child((user?.user.uid)!).setValue(userObject)
//          }else {
//
//            print(error?.localizedDescription as Any)
//
//            }
//        }
//      }
//
//      let cancelAction = UIAlertAction(title: "Cancel",
//                                       style: .cancel)
//
//        alert.addTextField { fullNameField in
//
//          fullNameField.placeholder = "Enter your full name"
//        }
//
//      alert.addTextField { textEmail in
//        textEmail.placeholder = "Enter your email"
//      }
//
//      alert.addTextField { textPassword in
//        textPassword.isSecureTextEntry = true
//        textPassword.placeholder = "Enter your password"
//      }
//
//
//
//      alert.addAction(saveAction)
//      alert.addAction(cancelAction)
//
//      present(alert, animated: true, completion: nil)
    }
    
    
//    @IBAction func signUpDidTouch(_ sender: Any)
    
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textFieldLoginEmail {
      textFieldLoginPassword.becomeFirstResponder()
    }
    if textField == textFieldLoginPassword {
      textField.resignFirstResponder()
    }
    return true
  }
}
