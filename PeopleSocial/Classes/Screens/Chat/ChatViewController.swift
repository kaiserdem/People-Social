//
//  ChatViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 26.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController { //  контроллре отображения

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var textField: UITextField!

  private var user: PSUser? // контроллер принимает сущность
  private var chat: Chat?
  private lazy var controller = ChatController.init(viewController: self, chat: chat!) // обьявляем
  
  convenience init(user: PSUser, chat: Chat) { // инициализируем сущность
    self.init()
    self.user = user
    self.chat = chat
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    controller.viewDidLoad()
  }
  @IBAction func sendClicked() {
    let text = textField.text
    controller.sendButtonClicked(with: text) // передаем текст в контроллер
  }
}

