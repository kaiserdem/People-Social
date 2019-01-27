//
//  PSUser.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 25.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

class PSUser: Codable { // модель пользователей
  var id: String?
  var birthday: TimeInterval?
  var email: String?
  var password: String?
  var sex: String?
  
}
