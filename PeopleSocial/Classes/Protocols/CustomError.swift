//
//  CustomError.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 08.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

enum Result<Value> {
  case success(Value)
  case failure(Error)
}

enum CustomErrors {
  case invalidEmail
  case unknowError
  case serverError
}
extension CustomErrors: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidEmail: // неверный адрес
      return NSLocalizedString("email_is_not_valid", comment: "")
    case .unknowError: // не известная ошибка
      return NSLocalizedString("server_error", comment: "")
    case .serverError: // ошибка сервера
      return NSLocalizedString("server_error", comment: "")
    }
  }
}
