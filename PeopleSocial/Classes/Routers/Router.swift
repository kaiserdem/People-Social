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
    
    private let rootViewController: UIViewController = ViewController()
    
    func root( _ window: inout UIWindow?) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.makeKeyAndVisible()
                                   // ставим навигейшен контроллре
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }
}
