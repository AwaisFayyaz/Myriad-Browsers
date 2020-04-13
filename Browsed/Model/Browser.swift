//
//  Browser.swift
//  Myriad
//
//  Created by MacBook on 2/4/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import Foundation
import Firebase

struct Browser {

//  let ref: DatabaseReference?
  var url: String
  let noOfBrowsers: Int
  let id: String
//  let key: String
//  let name: String

//  var completed: Bool

  init(url: String, id: String, noOfBrowsers: Int) {
//    self.ref = nil
    self.url = url
    self.noOfBrowsers = noOfBrowsers
    self.id = id
//    self.completed = completed
  }

//  init?(snapshot: DataSnapshot) {
//    guard
//      let value = snapshot.value as? [String: AnyObject],
//      let url = value["urlLink"] as? String,
//      let id = value["id"] as? String,
//      let noOfBrowsers = value["noOfTabs"] as? Int else {
//      return nil
//    }
//
//    self.ref = snapshot.ref
//    self.url = snapshot.key
//    self.url = url
//    self.id = id
//    self.noOfBrowsers = noOfBrowsers
//  }

    init?(dict: [String: AnyObject]) {
      guard
//        let value = snapshot.value as? [String: AnyObject],
        let url = dict["urlLink"] as? String,
        let id = dict["id"] as? String,
        let noOfBrowsers = dict["noOfTabs"] as? Int else {
        return nil
      }

//      self.ref = snapshot.ref
//      self.url = snapshot.key
      self.url = url
      self.id = id
      self.noOfBrowsers = noOfBrowsers
    }
    
  func toAnyObject() -> Any {
    return [
      "urlLink": url,
      "id": id,
      "numberOfTabs": noOfBrowsers
    ]
  }
}

//struct BrowsersDit {
//    let dict: [String: Any]
//
//      init(dict: [String: Any]) {
//        self.dict = dict
//      }
//
//    init?(snapshot: DataSnapshot) {
//      guard
//        let value = snapshot.value as? [String: AnyObject],
//        let url = value["urlLink"] as? String,
//        let id = value["id"] as? String,
//        let noOfBrowsers = value["noOfTabs"] as? Int else {
//        return nil
//      }
//
//      self.ref = snapshot.ref
//      self.url = snapshot.key
//      self.url = url
//      self.id = id
//      self.noOfBrowsers = noOfBrowsers
//    }
//
//    func toAnyObject() -> Any {
//      return [
//        "urlLink": url,
//        "id": id,
//        "numberOfTabs": noOfBrowsers
//      ]
//    }
//}

//class Browser: NSObject {
//    var urlLink: String?
//    var numberOfTabs: Int?
//    var id: String?
//}
