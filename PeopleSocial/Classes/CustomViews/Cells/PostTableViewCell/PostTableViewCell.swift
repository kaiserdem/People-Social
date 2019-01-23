//
//  PostTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 23.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var textView: UITextView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
}
