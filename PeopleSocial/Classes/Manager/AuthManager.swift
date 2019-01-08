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
  var currentUser: User? // текущий пользователь
  static let shared = AuthManager()
  private init() {}
  
  // указывает на первоначальную ветку в базе данных
  private var sourceRef: DatabaseReference {
    return Database.database().reference()
  }
  private var usersRef: DatabaseReference {
    return sourceRef.child("users")
  }
  private let auth = Auth.auth() // переменная авторизации
  
  // функция для авторизации
  func singIn(with email: String, and password: String, completion: @escaping ItemClosure<AuthResult>) {
    auth.signIn(withEmail: email, password: password) { (result, error) in
      if let error = error {
        completion(AuthResult.error(error.localizedDescription))// не удалось
        return
      }
      guard let user = result?.user else {
        completion(AuthResult.error("User not exist")) // не существует

        return
      }
      self.currentUser = user
      completion(AuthResult.success) // успешно
    }
  }
  
  // загружает модель данных
  func register(with model: RegisterModel, completion: @escaping ResultHandler<Void>) {
    // создаем модель нового пользователя ветки пользователя
    guard model.isFiled else {
      completion(.failure(CustomErrors.unknowError))
      return
    }
    guard let email = model.email, let password = model.password else {
      completion(.failure(CustomErrors.unknowError))
      return
    }
    guard Validators.isSimlpeEmail(email) else {
      completion(.failure(CustomErrors.invalidEmail))
      return
    }
    
    let id = model.userId // берем афди пользователя
    auth.createUser(withEmail: email, password: password) { result, error in
      if let error = error {
        completion(.failure(error))
      } else if let _ = result {
        var dict = model.dict
        dict["id"] = id
        self.usersRef.child(id).setValue(dict, withCompletionBlock: { (error, reference) in
        self.addAvatarUrlIfNeded(for: model) // загрузка фото
        completion(.success(()))
        })
      } else {
        completion(.failure(CustomErrors.unknowError))
      }
    }
  }             // добавляем ссылку на фото в бд
  func addAvatarUrlIfNeded(for model: RegisterModel) {
    StorageManager.shared.loadAvatarUrl(for: model) { (url) in // загружаем url
      guard let url = url else { // проверяем на нил
        return
      }// нашли юзера по child, создаем новую ветку, записываем в базу
      self.usersRef.child(model.userId).child("avatarUrl").setValue(url.absoluteString)
    }
  }
}


