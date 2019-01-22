//
//  PostManager.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 22.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Firebase

final class PostManager: FirebaseManager {
  private override init() {}
  
  static let shared = PostManager()
       // функция создания поста
  func createPost(from user: User, with text: String, completion: @escaping ItemClosure<FirebaseResult>) {
    let postID = UUID().uuidString // генерируем айди
    let post = Post(text: text) // создаем сам пост
    guard let dictionaty = post.dictionary  else { // пост помещаем в dictionaty
      completion(.error("Post model not dictionaty")) // если не получилось
      return
    }
    // обращаеимся к юзеру по айди, создаем папаку, задаем значения
    usersRef.child(user.uid).child(Keys.posts.rawValue).child(postID).setValue(dictionaty) { (error, reference) in
      if let error = error?.localizedDescription {
        completion(.error(error))
        return
      }
      completion(.success) // если все получилось
    }
  }
}
extension PostManager {
  fileprivate enum Keys: String {
    case posts
  }
}
