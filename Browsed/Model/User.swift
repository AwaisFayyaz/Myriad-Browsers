//
//  User.swift
//  Myriad
//
//  Created by MacBook on 2/5/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import Foundation
import Firebase

struct User {
  
  let uid: String
  let email: String
  
    init(authData: Firebase.User) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
}
