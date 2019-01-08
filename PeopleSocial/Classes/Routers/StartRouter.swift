//
//  StartRouter.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class StartRouter { // переносит по экратам
  
    static let shared = StartRouter()
    
    private init() {}
  
    func goToRegisterScreen(from source: UIViewController) {
        let vc = RegisterViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
    func goToLoginScreen(from source: UIViewController) {
        let vc = LoginViewController()
        source.navigationController?.pushViewController(vc, animated: true)
    }
  
}
