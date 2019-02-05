//
//  ContentWidth.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 05.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class ContentWidth {
  let width: CGFloat
  
  init(content: String, copyLable: UILabel) {
    let label = UILabel()
    label.numberOfLines = copyLable.numberOfLines
    label.font = copyLable.font
    label.text = content
    label.sizeToFit()
    self.width = label.frame.width
  }
  
}
