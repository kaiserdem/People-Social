//
//  FeedViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 20.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private var posts: [Post] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    delegating()
    registerCells()
    
    PostManager.shared.loadingAllPosts { (result) in
      switch result {
      case .error(let error):
        self.title = error
      case .success(let posts):
        self.posts = posts
        self.title = "News"
      }
    }
  }
  private func delegating() { // подписали делегаты
    tableView.delegate = self
    tableView.dataSource = self
  }
  private func registerCells() { // регистрация ячейки
    tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.name)
  }
}
extension FeedViewController: UITableViewDelegate { // высота строки
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }                       // расчитать высоту для строки
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 346 // первое
  }
}
extension FeedViewController: UITableViewDataSource {
  // настройка ячейки
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.name, for: indexPath) as! PostTableViewCell
    cell.sutup(with: posts[indexPath.row]) // второе
    return cell
  }                               // колич рядов в секции
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
}
