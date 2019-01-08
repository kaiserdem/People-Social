//
//  Validator.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 08.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

enum Validators { // проверка
  static func isSimlpeEmail(_ email: String) -> Bool {
    let emailRegEx = "^.+@.+\\..{2,}$"
    return check(text: email, regEx: emailRegEx)
  }
  private static func check(text: String, regEx: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
    return predicate.evaluate(with:text)
  }
}
