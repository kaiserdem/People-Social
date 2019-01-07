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
  func set(titels: [String]) { // задаем пол
    segmentControl.removeAllSegments()
    titels.enumerated().forEach { (i, titel) in
      segmentControl.insertSegment(withTitle: titel, at: i, animated: true)
    }
    segmentControl.selectedSegmentIndex = 0 // пол по умолчанию
  }
  private func addTargets() {
    segmentControl.addTarget(self, action: #selector(segmentControlChangedIndex(sender:)), for: .valueChanged)
  }
  @objc private func segmentControlChangedIndex(sender:UISegmentedControl) {
     indexChanged?(sender.selectedSegmentIndex)
  }
}
