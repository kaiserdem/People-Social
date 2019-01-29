//
//  AppDelegate.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    Router.shared.root(&window) // зугружает нужное окно
    FirebaseApp.configure()
    AuthManager.shared.singInIfNeeded { [unowned self] _ in
      UserManager.shared.fetchCurrentUser()
    }
    return true
  }
}


//UserManager.shared.loadingUsers { users in
//  let chat = Chat(id:"newChat", users:[users.first!, UserManager.shared.currentUser!])
//  ChatManager.shared.startChat(chat: chat, callback: {
//
//  })
//}



//    let chat = Chat()
//        chat.id = "13"
//    ChatManager.shared.loadingMessages(chat: chat) { (messages) in
//      print(messages)
//    }


//    let message = Message()
//    message.senderId = "13"
//    message.text = "Test"
//    message.time = Date().timeIntervalSince1970
//    let chat = Chat()
//    chat.id = "123"
//    ChatManager.shared.send(message: message, on: chat)

//    SecureStorageManager.shared.eraseUserDataIfNedded() // удалить пользовательскте данные
