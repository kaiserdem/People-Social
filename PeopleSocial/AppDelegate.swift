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
    AuthManager.shared.singInIfNeeded()
    
//    SecureStorageManager.shared.eraseUserDataIfNedded() // удалить пользовательскте данные
    
    return true
  }
}

