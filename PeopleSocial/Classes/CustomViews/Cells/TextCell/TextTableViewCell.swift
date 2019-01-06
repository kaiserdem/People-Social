//
//  TextTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var lable: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none // ячейку нельзя выделять

  }
  
  func set(text: String) {
    lable.text = text
  }
    
}
