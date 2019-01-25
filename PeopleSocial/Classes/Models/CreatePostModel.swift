//
//  CreatePostModel.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 24.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

final class CreatePostModel { // Модель 
  private(set) var text: String?
  private(set) var image: UIImage?
  
  func set(text: String?) {
    self.text = text
  }
  func set(image: UIImage?) {
    self.image = image
  }
  
  var imageData: Data? { // возвращает данные 
    return image?.jpegData(compressionQuality: 0.5)
  }
  var isField: Bool { //поле не пустое
    return text != nil || image != nil
  }
}
