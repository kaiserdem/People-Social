//
//  HeaderTitleView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class HeaderTitleView: UIView, NibLoadable {
  @IBOutlet private weak var lable: UILabel!
  
  func set(title: String) { // функция ставит тайтел 
    lable.text = title
  }
}
