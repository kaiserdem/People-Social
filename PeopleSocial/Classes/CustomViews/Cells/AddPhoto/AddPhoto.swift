//
//  AddPhoto.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 04.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class AddPhoto: UITableViewCell, NibLoadable {
  
  @IBOutlet private weak var circleBackground: UIView!
  @IBOutlet private weak var cameraImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
  override func layoutSubviews() {
    super.layoutSubviews()
                // закругляем вю
    circleBackground.layer.cornerRadius = circleBackground.frame.height / 2
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
