//
//  InfoUserTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class InfoUserTableViewCell: UITableViewCell, StaticCellProtocol {
  
  @IBOutlet weak var photoView: PhotoView!
  
  static var heigth: CGFloat {
    return 100
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    Decoretor.decorator(cell: self)
  }
  
}

extension InfoUserTableViewCell {
  fileprivate class Decoretor {
    static func decorator(cell: InfoUserTableViewCell) {
      cell.selectionStyle = .none // что б ячейка не выделялась
      cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1) // цвет ячейки
    }
  }
}
