//
//  InfoUserTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell, StaticCellProtocol {
  
  @IBOutlet private weak var photoView: PhotoView!
  @IBOutlet private weak var backgroundFieldView: UIView!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  static var heigth: CGFloat { // высота
    return 100
  }
  
  var photoViewClicked: VoidClosure? { // 
    didSet {
      photoView.clicked = photoViewClicked // по касанию задаетьяся картинка на фотовю
    }
  }
  // клоужер отдает действие что текст изменился, и передает текст
  var emailTextChanged: ItemClosure<String>?
  var passwordTextChanged: ItemClosure<String>?

  override func awakeFromNib() {
    super.awakeFromNib()
    
    Decoretor.decorator(cell: self)
      addTargets()
  }
  private func addTargets() {
    emailTextField.addTarget(self, action: #selector(emailTextFieldChanged(sender:)), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged(sender:)), for: .editingChanged)
  }                         // изменение в поле текст филд
  @objc private func emailTextFieldChanged(sender: UITextField) {
    emailTextChanged?(sender.text ?? "")
  }
  @objc private func passwordTextFieldChanged(sender: UITextField) {
    passwordTextChanged?(sender.text ?? "")
  }
  
  func set(image: UIImage?) { // функция задает картинку
    photoView.set(image: image)
  }
}

extension InfoUserTableViewCell {
  fileprivate class Decoretor {
    static func decorator(cell: InfoUserTableViewCell) {
      
      cell.selectionStyle = .none // что б ячейка не выделялась
      cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
      cell.backgroundFieldView.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)// цвет ячейки
      cell.backgroundFieldView.layer.borderWidth = 0.5
    }
  }
}
