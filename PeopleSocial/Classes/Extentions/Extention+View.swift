//
//  Extention+View.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

extension UIView {
  
  func round() {     // округляет вю
    layer.cornerRadius = frame.height / 2
  }
}
extension UIView {
  enum SeparatorPosition: Int {
    case top = 5
    case boottom = 10
  }
  func addSeparator(on position: SeparatorPosition, insets: UIEdgeInsets = .zero) {
    let tag = 0x2345 * position.rawValue
    
    guard self.viewWithTag(tag) == nil else {// вю не должно сществовать
      return
    }
    let separatopView = UIView()
    separatopView.backgroundColor = #colorLiteral(red: 0.7333333333, green: 0.7607843137, blue: 0.7921568627, alpha: 1)
    separatopView.translatesAutoresizingMaskIntoConstraints = false
    let height = 0.5
    let verticalFormat = position == .top ? "|[separatopView(\(height))]" : "[separatopView(\(height))]|"
    addSubview(separatopView)
    let constrains = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[separatopView]|,V:\(verticalFormat)", dict: ["separatopView": separatopView])
    addConstraints(constrains)
  }
}
