//
//  Message.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 26.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

final class Message: Codable { // модель сообщений
  var id: String
  var senderId: String? //идентификатор пользователя отправителя
  var text: String?
  var time: TimeInterval?
  
  init() { // инициализатор для id
    id = UUID().uuidString
  }
  var isSenderOponent: Bool {
    return senderId != UserManager.shared.currentUser?.id
  }
  convenience init(text: String) {
    self.init()
    self.senderId = UserManager.shared.currentUser?.id
    self.text = text
    self.time = Date().timeIntervalSince1970
  }
  func getText() -> String { // получаем текст
     return text ?? "" // если текст не существует отправляем пустую переменную
  }
  func getFormatTime() -> String {// возвращает время в нужном виде
    if let time = time {
      let date = Date.init(timeIntervalSince1970: time)
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      return dateFormatter.string(from: date)
    } else {
      return "???"
    }
  }
}
