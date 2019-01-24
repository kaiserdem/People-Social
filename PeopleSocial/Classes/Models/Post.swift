//
//  Post.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 22.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Firebase

class Post: Codable {    // модель поста
  
  enum `Type`: String, Codable { // тип загружаемых данных
    case text
    case textAndImage
    case image
  }
  var id: String
  var type: Type
  var text: String?
  var imageData: Data?
  var dateUnix: TimeInterval
  
  init() {
    self.id = UUID().uuidString
    self.dateUnix = Date().timeIntervalSinceNow
    self.type = .text
  }
  
  convenience init(text: String) {
    self.init()
    self.type = .text
    self.text = text
  }
  convenience init(imageData: Data) {
    self.init()
    self.type = .image
    self.imageData = imageData
  }
  convenience init(text: String?, imageData: Data?) {
    if let text = text, let imageData = imageData {
      self.init()
      self.text = text
      self.imageData = imageData
      self.type = .textAndImage
    } else if let text = text {
      self.init(text: text)
    }else if let imageData = imageData {
      self.init(imageData: imageData)
    } else {
      self.init()
    }
  }
}
