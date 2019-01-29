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
  
  func send(message: Message, on chat: Chat) { // отправка сообщения в указаный чат
    guard let dict = message.dictionary else { // если может конвертироваться в дикшинари
      return
    }
    guard let chatId = chat.id else { // если айдти часа существует
      return
    }
    // сохранили новое сообщение и добавили
    chatsRef.child(chatId).child("message").child(message.id).setValue(dict)
  }
  // загрузить чат если необходимо
  func startChatIfNedded(chat: Chat, callback: @escaping VoidClosure) {
    checkIsChatExist(chat: chat) { (result) in
      if result {
        self.startChat(chat: chat, callback: callback)
      }
    }
  }
  func checkIsChatExist(chat: Chat, callback: @escaping ItemClosure<Bool>) {//создан ли чат
    guard let chatId =  chat.id else {
      return
    }
    chatsRef.child(chatId).observeSingleEvent(of: .value) { (snapshot) in
      callback(snapshot.exists())
    }
  }
  // создает чат с изначальными инициализациями
  func startChat(chat: Chat, callback: @escaping VoidClosure) {
    guard let chatId = chat.id else {
      return
    }
    guard let chatDict = chat.dictionary else {
      return
    }
    chatsRef.child(chatId).setValue(chatDict) { (error, ref) in
      callback()
    }
  }
  func loadingChats(callback: @escaping ItemClosure<[Chat]>) { // загрузка чатов
    chatsRef.observe(.value) { (snapshot) in
      if let dict = snapshot.value as? [String: Any] {
        
        let chats = dict.map({ (element) -> Chat? in
          let chatId = element.key
          
          if let chatDict = element.value as? [String : Any], let usersDict = chatDict["users"] as? [[String: Any]] {
            let users = usersDict.map { try? PSUser.init(from: $0 ) }.compactMap { $0 }
            return Chat.init(id: chatId, users: users)
          }
          return nil
        }).compactMap { $0 }
        callback(chats)
      }
    }
  }
  // иерархия будет такая Chat -> id айди чата -> messages масив сообщений
  // функция загрузки сообщений, передаем модель данных
  func  loadingMessages(chat: Chat, callBack: @escaping ItemClosure<[Message]>) {
    guard let chatId = chat.id else { //  проверка
      return
    }
           // обращаемся по id айди чата и ветке сообщений
     let messagesRef = chatsRef.child(chatId).child("message")
    messagesRef.observe(.value) { (snapshot) in // snapshot это ветка сообщений
      if let dict = snapshot.value as? [String: [String: Any]] { // кладем в масив дикш
        // сортируем по времени и убираем опциналци
        let messages = dict.map { try? Message.init(from: $0.value) }.compactMap { $0 }.sorted { $0.time ?? 0 < $1.time ?? 0}
        callBack(messages)
      }
    }
  }
}
