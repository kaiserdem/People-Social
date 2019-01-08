//
//  StorageManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 08.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageManager { // менеджер хранилища
  static let shared = StorageManager()
  private init() {}
  
  // указывает на первоначальную ветку в базе данных
  private let sourceRef = Storage.storage().reference()
  
  // принимает фото, возвращает по айди клоужер(опционально)
  func  upload(photo: UIImage,by model:RegisterModel, closure: VoidClosure? = nil) {
    //  переобразоваваем тип фото UIImage в тип дата
    guard let data = photo.jpegData(compressionQuality: 0.5) else {
      return
    }
    // создаем ветку avatars, по userId кладем фото
    sourceRef.child(Keys.avatars.rawValue).child(model.userId).putData(data, metadata: nil) { (metadata, error) in
      closure?()
    }
  }
  //  загрузка аватара по url
  func loadAvatarUrl(for model: RegisterModel, closure: @escaping OptionalItemClosure<URL>) {
    sourceRef.child(Keys.avatars.rawValue).child(model.userId).downloadURL { (url, error) in
      closure(url)
    }
  }
}
// хранилище для ключей веток
extension StorageManager {
  private enum Keys: String { 
    case avatars
  }
}
