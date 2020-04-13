//
//  SignupViewController.swift
//  Myriad
//
//  Created by MacBook on 2/3/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews(){
        
        
//        Auth.auth().addStateDidChangeListener() { auth, user in
//          if user != nil {
//            
//            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! ViewController
//            self.navigationController?.pushViewController(homeVC, animated: true)
//            
////            self.performSegue(withIdentifier: self.loginToList, sender: nil)
////            self.textFieldLoginEmail.text = nil
////            self.textFieldLoginPassword.text = nil
//          }
//        }
        
//        let ref = Database.database().reference()
//        ref.child("users").setValue("Hamza Amin")
        
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        
//        { _ in
                
        let firstNameText = firstNameTextField.text!
        let lastNameText = lastNameTextField.text!
        let emailText = emailTextField.text!
        let passwordText = passwordTextField.text!
//
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { user, error in
          if error == nil {
            Auth.auth().signIn(withEmail: emailText,
                               password: passwordText)
            let userObject = [
                "id": user?.user.uid,
                "name": "\(firstNameText) \(lastNameText)",
               "password": passwordText, // I don't recommend storing passwords like this by the way
                "email": emailText
            ] as [String:Any]
            let ref = Database.database().reference()
            ref.child("users").child((user?.user.uid)!).setValue(userObject)
          }else {
            
            print(error?.localizedDescription as Any)
            
            }
        }
//              }
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
