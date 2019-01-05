//
//  InfoUserTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell, StaticCellProtocol {
  
  static var heigth: CGFloat {
    return 100
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    //contentView.backgroundColor = .yellow
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
