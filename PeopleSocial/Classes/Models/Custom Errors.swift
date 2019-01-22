//
//  CustomErrors.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 21.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

enum Result<Value> {
  case success(Value) // успех
  case failure(Error) // отказ
}
enum CustomErrors {
  case invalidEmail // не верный адрес почты
  case unknownError // неизвестная ошибка
  case serverError  // ошибка сервера
  case keychainError
  case biometricAuthError(String)
}
extension CustomErrors: LocalizedError {
  
  var errorDescription: String? {
    switch  self {
    case .invalidEmail: // неверный адрес
      return NSLocalizedString("email_is_not_valid", comment: "")
    case .unknownError: // не известная ошибка
      return NSLocalizedString("server_error", comment: "")
    case .serverError: // ошибка сервера
      return NSLocalizedString("server_error", comment: "")
    case .keychainError:
      return NSLocalizedString("keychain_error", comment: "")
    case .biometricAuthError(let error):
      return error
    }
  }
}
