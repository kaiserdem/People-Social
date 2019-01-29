//
//  TextMessageTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 29.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell {
  @IBOutlet weak var cloudView: UIView!
  @IBOutlet weak var messageLable: UILabel!
  @IBOutlet weak var timeLable: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none // нельзя выделить
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    cloudView.layer.cornerRadius = 10 
  }
  
  func configure(by message: Message) {
    messageLable.text = message.getText()
    timeLable.text = message.getFormatTime()
  }
}
extension TextMessageTableViewCell {
  // возвращает имя ниба за счет будевой переменной
  static func nibName(isOponent: Bool) -> String {
    switch isOponent {
    case true: return "OponentTextMessageTableViewCell"
    case false: return "MyTextMessageTableViewCell"
      
    }
    
  }
  static func nib(isOponent: Bool) -> UINib { // возвращает ниб
    return UINib.init(nibName: nibName(isOponent: isOponent), bundle: Bundle.main)
  }
}
