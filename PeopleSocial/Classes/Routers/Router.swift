//
//  Router.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class Router {
  static let shared = Router()
  
  private init() {}
  
  func root( _ window: inout UIWindow?) {
    let frame = UIScreen.main.bounds
    window = UIWindow(frame: frame)
    window?.makeKeyAndVisible()
    
    // если залогинен тогда CreatePostViewController, в противном случаем ViewController
    let vc = SecureStorageManager.shared.isLoggedIn() ? startControllerAfterAuth : ViewController()
    // ставим навигейшен контроллре
    window?.rootViewController = UINavigationController(rootViewController: vc)
  }
  // переменная указывает какой контроллер загружать
  var startControllerAfterAuth: UIViewController {
    
    let createPostVC = CreatePostViewController()
    let createPostNC = UINavigationController(rootViewController: createPostVC)
    let createPostTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0) // елемент бара
    createPostNC.tabBarItem = createPostTabBarItem // елемент соответствует контроллеру
    
    let feedVC = FeedViewController()
    let feedNC = UINavigationController(rootViewController: feedVC)
    let feedTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    feedNC.tabBarItem = feedTabBarItem
    
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([feedNC, createPostNC], animated: true)
    return tabBarVC
  }
}
