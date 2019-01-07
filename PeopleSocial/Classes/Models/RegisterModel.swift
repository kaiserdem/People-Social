//
//  RegisterModel.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class RegisterModel { // создаем модель
  var photo: UIImage?
  var email: String?
  var password: String?
  var sex: Sex = .male // по дефолту
  var birthday: Date?
  
  var isFiled: Bool { // все ли поля заполнены
    guard !(email ?? "").isEmpty, !(password ?? "").isEmpty, birthday != nil else {
      return true
    }
    return true

  }
}
