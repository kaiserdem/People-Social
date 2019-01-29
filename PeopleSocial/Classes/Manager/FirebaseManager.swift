//
//  FirebaseManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 22.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
  
  // указывает на первоначальную ветку в базе данных
   var sourceRef: DatabaseReference {
    return Database.database().reference()
  }
   var usersRef: DatabaseReference { // создаем ветку
    return sourceRef.child("users")
  }
  var chatsRef: DatabaseReference { // создаем ветку
    return sourceRef.child("chats")
  }
}
