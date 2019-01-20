//
//  UserHeaderView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 20.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class UserHeaderView: UIView, NibLoadable {
  
  @IBOutlet private weak var avatarView: UIImageView!
  @IBOutlet private weak var userNameLable: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    avatarView.round() // закругляет вю
  }
  
}
