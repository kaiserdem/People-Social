//
//  UserManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 25.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Firebase

final class UserManager: FirebaseManager {
  static let shared = UserManager()
  
  func loadingUsers(completion: @escaping ItemClosure<[PSUser]>) { // загрузка пользователей
    usersRef.observe(.value) { (snapshot) in // получаем ветку users
      if let dict = (snapshot.value as? [String:[String: Any]]) {
        completion(dict.map({ (userDict) -> PSUser in
          return try! PSUser(from: userDict.value)
        }))
      }
    }
  }
}
