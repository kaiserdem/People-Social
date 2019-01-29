//
//  UsersViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 29.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private var users: [PSUser] = [] {
    didSet {               // если изменились
      tableView.reloadData() // обновляем таблицу
    }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      delegating()
      UserManager.shared.loadingUsers {
        users in
        self.users = users
      }
  }
      private func delegating() {
        tableView.delegate = self
        tableView.dataSource = self
      }
  }
  extension UsersViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let currentUser = UserManager.shared.currentUser else { // если пользов существ
        return
      }
      let user = users[indexPath.row]
      let chat = Chat.init(id: UUID().uuidString, users: [currentUser, user])
      ChatManager.shared.startChatIfNedded(chat: chat) {
        self.showAlert(with: "Ready", and: "Chat created")
      }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 44
    }
  }
  extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell()
      let user = users[indexPath.row]
      cell.textLabel?.text = user.email ?? user.id
      return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users.count
    }
}

