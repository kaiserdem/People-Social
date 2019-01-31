//
//  TitleHeaderView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 30.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TitleHeaderView: UIView, NibLoadable {
  
  @IBOutlet private weak var lable: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  func set(text: String?) { // задать текст лейбла
    lable.text = text
  }
}
