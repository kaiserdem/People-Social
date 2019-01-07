//
//  AuthManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 07.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AuthManager {
  static let shared = AuthManager()
  private init() {}
  
  // указывает на первоначальную ветку в базе данных
  private var sourceRef: DatabaseReference {
    return Database.database().reference()
  }
  private let auth = Auth.auth() // переменная авторизации
  
  // функция выполняет регистрацию
  func register(with model: RegisterModel, completion: VoidClosure) { //
    guard model.isFiled else {
      return
    }
    guard let email = model.email, let password = model.password else {
      return
    }
     let usersRef = sourceRef.child("user") // создаем ветку в базе
    //let id = UUID.init().uuidString
    let id = ID() // айди пользователя
    auth.createUser(withEmail: email, password: password) { result, error in
      var dict = model.dict // масив данных пользователя
      dict["id"] = id
      usersRef.child(id).setValue(dict)
    }
  }
}
