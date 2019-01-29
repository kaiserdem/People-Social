//
//  ChatDataProvider.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 28.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation // отдает данные в нужном нам формате

final class ChatDataProvider {
  private var messages:[Message] = [] 
  
  func set(messages: [Message]) { // принимает модель
    self.messages = messages
  }
  func numberOfRows() -> Int{ // кол рядов
    return messages.count
  }
  func message(by indexPath: IndexPath) -> Message { // отдает сообщения по индекс пас
    return messages[indexPath.row]
  }
}
