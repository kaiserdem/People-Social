//
//  DetailFieldTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 29.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class DetailFieldTableViewCell: UITableViewCell, NibLoadable, HeigtContainable {

  @IBOutlet weak private var label: UILabel!
  @IBOutlet weak private var textField: UITextField!
  @IBOutlet weak private var labelWidthConstraints: NSLayoutConstraint!

  static var heigth: CGFloat { // высота ячейки
    return 54
  }
  var textChanged: ItemClosure<String>?
  
    override func awakeFromNib() {
        super.awakeFromNib()
      separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
      selectionStyle = .none
      label.textAlignment = .right
      addTargets()
    }
  private func addTargets() {
    textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
  }
  @objc private func textFieldChanged() {
    let text = textField.text ?? ""
    textChanged?(text)
  }
  func activeTextField() { // при старет поле ввода активно
    textField.becomeFirstResponder()
  }
  func set(secure: Bool) { // скрыть пароль
    textField.isSecureTextEntry = secure
  }
  func set(title: String?) { // задать титул
    label.text = title
  }
  func adjustWidth(by titles: [String]) { // автоматический размер максимальноый ширены лейбла
    var width: CGFloat = 0
    for title in titles {
      let label = UILabel()
      label.numberOfLines = self.label.numberOfLines
      label.font = self.label.font
      label.text = title
      label.sizeToFit()
      width = max(width, label.frame.width)
    }
    labelWidthConstraints.constant = width
  }
  func set(placeholder: String?) { // задать плейсхолдер
    textField.placeholder = placeholder
  }
}
