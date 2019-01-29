//
//  Extentions+TextView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 23.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

final class TextView: UITextView {
  
  override public var bounds: CGRect {
    didSet {
      self.resizePlaceholder()
    }
  }
  var placeholder: String? { // создаем плейсхолдер
    get {
      var placeholderText: String?
      
      if let placeholderLable = self.viewWithTag(100) as? UILabel {
        placeholderText = placeholderLable.text
      }
      return placeholderText
    }
    set {
      if let placeholderLable = self.viewWithTag(100) as! UILabel? {
        placeholderLable.text = newValue
        placeholderLable.sizeToFit()
      } else {
        self.addPlaceholder(newValue!)
      }
    }
}
  deinit {
    NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
  }
}
  private extension TextView {
    
    func resizePlaceholder() {
      if let placeholderLable = self.viewWithTag(100) as! UILabel? {
        let labelX = self.textContainer.lineFragmentPadding
        let labelY = self.textContainerInset.top - 2
        let labelWidth = self.frame.width - (labelX * 2)
        let labelHeight = placeholderLable.frame.height
        
        placeholderLable.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)

      }
    }
    
    func addPlaceholder(_ placeholderText: String) { // внуутри TextView создаем лейбл
      let placeholderLable = UILabel()
      
      placeholderLable.text = placeholderText
      placeholderLable.sizeToFit()
      
      placeholderLable.font = self.font
      placeholderLable.textColor = UIColor.lightGray
      placeholderLable.tag = 100
      
      placeholderLable.isHidden = self.text.count > 0
      
      self.addSubview(placeholderLable)
      self.resizePlaceholder()
      
      NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    @objc func textViewDidChange() {
      if let placeholderLable = self.viewWithTag(100) as? UILabel {
        placeholderLable.isHidden = self.text.count > 0
      }
    }
}
