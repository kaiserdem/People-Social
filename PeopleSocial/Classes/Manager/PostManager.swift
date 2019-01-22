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
  
  enum Result {
    case success([Post]) // масив постов
    case error(String)
  }
  
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
  // функция загружает все посты
  func loadingAllPosts(completion: @escaping ItemClosure<Result>) {
    // наблюдатель за значением
    usersRef.observe(.value) { (snapshot) in
      var result: [Post] = [] // пустой масив постов
      
       // кладем занчение из снепшот в масив
      guard let value = snapshot.value as? [[AnyHashable: Any]] else {
        completion(.error("Post not exist"))
        return
      }
      for element in value {
        // получили доступ к масиву постов в виде дикширани AnyHashable
        if let postsDictionaryArray = (element[Keys.posts] as? [[AnyHashable: Any]]) {
          // создаем масив постов
          let posts = postsDictionaryArray.compactMap { try? Post.init(from: $0) }
          // сложили два масива
          result.append(contentsOf: posts) //сложили два масива
        }
      }
      completion(.success(result)) // когад прошли циклом  возвращаем масив
    }
  }
}
extension PostManager {
  fileprivate enum Keys: String {
    case posts
  }
}
