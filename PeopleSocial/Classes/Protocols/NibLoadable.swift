//
//  NibLoadable.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

protocol NibLoadable: class { //позволяем получать доступ к nib из класса
  static var nib: UINib { get }
}
extension NibLoadable {
  static var nib: UINib {
    return UINib(nibName: name, bundle: Bundle.init(for: self))
  }
  static var name: String { // имя для обрашения 
    return String(describing: self)
  }
}
extension NibLoadable where Self: UIView { // функция возвращает вю 
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nib, options: nil).first as? Self  else {
      fatalError()
    }
    return view
  }
}
