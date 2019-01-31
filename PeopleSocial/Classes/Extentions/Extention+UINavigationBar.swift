//
//  Extention+UINavigationBar.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 30.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit.UINavigationBar

extension UINavigationBar {
  func makeClear() { // прозрачный нав бар
    backgroundColor = .clear
    setBackgroundImage(UIImage(), for: .default)
    shadowImage = UIImage()
  }
}
