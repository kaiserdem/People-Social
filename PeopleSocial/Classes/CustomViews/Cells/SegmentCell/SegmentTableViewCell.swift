//
//  SegmentTableViewCell.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class SegmentTableViewCell: UITableViewCell, NibLoadable {
  
  @IBOutlet private weak var segmentControl: UISegmentedControl!
  
  var indexChanged: ItemClosure<Int>? // опциональный клоужер для обращения
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    selectionStyle = .none // ячейку нельзя выделять
    addTargets()
  }
  
  private func addTargets() {
    segmentControl.addTarget(self, action: #selector(segmentControlChangedIndex(sender:)), for: .valueChanged)
  }
  @objc private func segmentControlChangedIndex(sender:UISegmentedControl) {
     indexChanged?(sender.selectedSegmentIndex)
  }
}
