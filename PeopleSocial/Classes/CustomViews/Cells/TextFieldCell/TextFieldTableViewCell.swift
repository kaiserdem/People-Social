//
//  TextFieldTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var textField: UITextField!
  
  // клоужер отдает действие что текст изменился, и передает текст
  var textChanged: ItemClosure<String>?
  
    override func awakeFromNib() {
        super.awakeFromNib()
      addTargets()
  }
  private func addTargets() {
    textField.addTarget(self, action: #selector(textFieldChanged(sender:)), for: .editingChanged)
  }// вызываеться при изменении в поле
  @objc private func textFieldChanged(sender: UITextField) {
    textChanged?(sender.text ?? "")
  }
}
