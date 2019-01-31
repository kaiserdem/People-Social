//
//  TextFooterView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 30.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TextFooterView: UIView, NibLoadable {

  @IBOutlet weak private var textView: UITextView!

  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(text: String?) { // задать текст
    textView.text = text
  }
}
