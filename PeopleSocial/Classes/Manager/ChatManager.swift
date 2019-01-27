//
//  ChatManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 27.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

final class ChatManager: FirebaseManager {
  static let shared = ChatManager()
  
  func send(message: Message) { // отправка сообщения
    guard let dict = message.dictionary else { // если может конвертироваться в дикшинари
      return
    }
    sourceRef.child(message.id).setValue(dict) // кладем сообщение в масив в базе
  }
}
