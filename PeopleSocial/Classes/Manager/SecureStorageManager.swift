//
//  SecureStorageManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 20.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Locksmith   // хранит данные в шифрованом виде

final class SecureStorageManager { // менеджер безопасного хранения
  static let shared = SecureStorageManager()
  
  let myUserAccountIdentifier = "MyUserAccountIdentifier"
  
  private init() {}
  // сохраняем данные
  func save(email: String?, password: String?, completionHandler: ItemClosure<CustomErrors?>) {
    guard let email = email, let password = password else { // если существует
      completionHandler(CustomErrors.keychainError)
      return
    }
    let data = [Keys.email.rawValue: email,
                Keys.password.rawValue: password]
    do {
      try Locksmith.saveData(data: data, forUserAccount: myUserAccountIdentifier)
      completionHandler(nil) //сохраняем дату
    }
    catch {
      completionHandler(CustomErrors.keychainError)
    }
  }
  func eraseUserDataIfNedded() { // стереть данные пользователя из кичейн
    guard isLoggedIn() else {
      return
    }
    try? Locksmith.deleteDataForUserAccount(userAccount: myUserAccountIdentifier)
  }
  // загрузить электронную почту и пароль
  func loadEmailAndPassword() -> (email: String?, password: String?) {
    let dictionary = Locksmith.loadDataForUserAccount(userAccount: myUserAccountIdentifier)
    let email = dictionary?[Keys.email.rawValue] as? String ?? nil
    let password = dictionary?[Keys.password.rawValue] as? String ?? nil
    return (email: email, password: password)
  }
  // Проверяем вошел ли пользователь, что б второй раз не вводить пароль
  func isLoggedIn() -> Bool {// залогинен
    let credentials = loadEmailAndPassword() // полномочия на загрузку данных
    return credentials.email != nil && credentials.password != nil
  }
}
private extension SecureStorageManager {
  enum Keys: String {
    case email
    case password
  }
}
