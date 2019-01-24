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
       // функция создания поста c  изображением
  func createPost(from user: User, with text: String? = nil, image: UIImage? = nil,  completion: @escaping ItemClosure<CreatedPostResult>) {
    if let text = text, text.isEmpty, image == nil {
      completion(.error("Can't create empty post"))
      return
    }
    let post = Post(text: text, imageData: image?.jpegData(compressionQuality: 0.5))
    
    guard let dictionaty = post.dictionary  else { // пост помещаем в dictionaty
      completion(.error("Post model not dictionaty")) // если не получилось
      return
    }
    // обращаеимся к юзеру по айди, создаем папаку, задаем значения
    usersRef.child(user.uid).child(Keys.posts.rawValue).child(post.id).setValue(dictionaty) { (error, reference) in
      if let error = error?.localizedDescription {
        completion(.error(error))
        return
      }
      completion(.success(post))// если все получилось
    }
  }
  // функция загружает все посты
  func loadingAllPosts(completion: @escaping ItemClosure<LoadedPostsResult>) {
    // наблюдатель за значением
    usersRef.observe(.value) { (snapshot) in
      var result: [Post] = [] // пустой масив постов
      
       // кладем занчение из снепшот в масив
      guard let value = snapshot.value as? [String: [AnyHashable: Any]] else {
        completion(.error("Post not exist"))
        return
      }
      let allKeys = value.keys
      allKeys.forEach({ (key) in
        
        // получили доступ к масиву постов в виде дикширани AnyHashable
        if let element =  value[key], let postsDictionaryArray = (element[Keys.posts.rawValue] as? [String: [AnyHashable: Any]]) {
          // создаем масив постов
          let posts = postsDictionaryArray.compactMap { try? Post.init(from: $0.value) }
          // сложили два масива
          result.append(contentsOf: posts) //сложили два масива
        }
      })
      completion(.success(result)) // когад прошли циклом  возвращаем масив
    }
  }
}
extension PostManager {
  
  fileprivate enum Keys: String {
    case posts
  }
  
  enum LoadedPostsResult { //результат загрузки поста
    case success([Post])
    case error(String)
  }
  
  enum CreatedPostResult { // результат созадния поста
    case success(Post)
    case error(String)
  }
}
