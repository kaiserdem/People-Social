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
  
  init(text: String) {
    self.id = UUID().uuidString
    self.type = .text
    self.text = text
  }
}
