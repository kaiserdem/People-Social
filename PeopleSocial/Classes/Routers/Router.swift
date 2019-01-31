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
    
    let chatsVC = ChatsViewController()
    let chatsNC = UINavigationController.init(rootViewController: chatsVC)
    let chatsTabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
    chatsNC.tabBarItem = chatsTabBarItem
    
    let usersVC = UsersViewController()
    let usersNC = UINavigationController.init(rootViewController: usersVC)
    let usersTabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
    usersNC.tabBarItem = usersTabBarItem
    
    let feedVC = FeedViewController()
    let feedNC = UINavigationController(rootViewController: feedVC)
    let feedTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    feedNC.tabBarItem = feedTabBarItem
    
    let searchVC = SearchViewController()
    let searchNC = UINavigationController(rootViewController: searchVC)
    let searchTabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
    searchNC.tabBarItem = searchTabBarItem
    
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([feedNC, searchNC, usersNC, chatsNC, createPostNC], animated: true)
    return tabBarVC
  }
}
