//
//  Chat.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 27.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

class Chat: Codable {
  var id: String? 
  var messages:[Message] = [] // масив сообщений
  var users: [PSUser] = [] // масив пользователей
  
  init(id: String, users: [PSUser]) { // для первого чата
    self.id = id
    self.users = users
  }
  // масив собеседника
  var oponent: PSUser? {
    return users.filter { UserManager.shared.currentUser?.id != $0.id }.first
  }
}
