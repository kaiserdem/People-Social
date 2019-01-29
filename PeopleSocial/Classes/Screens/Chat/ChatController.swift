//
//  ChatController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 27.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

final class ChatController: NSObject {
  
  weak var viewController: ChatViewController? // указываем ссылку на вю контроллер
  
  
  var tableView: UITableView? {
    return viewController?.tableView
  }
  var chat: Chat?
  private let dataProvider = ChatDataProvider()
  
  init(viewController: ChatViewController, chat: Chat?) { // инициализируем вю контроллре и сущность
    self.viewController = viewController
    self.chat = chat
  }
  private func startObservingMessages() {
    guard let chat = self.chat else {
      return
    }
    ChatManager.shared.loadingMessages(chat: chat) { (messages) in
      self.dataProvider.set(messages: messages)
      self.tableView?.reloadData()
    }
  }
  private func registerCells() { // регистрируем ячейку
     tableView?.register(TextMessageTableViewCell.nib(isOponent: false), forCellReuseIdentifier: TextMessageTableViewCell.nibName(isOponent: false))
    
    tableView?.register(TextMessageTableViewCell.nib(isOponent: true), forCellReuseIdentifier: TextMessageTableViewCell.nibName(isOponent: true))
  }
  private func delegating() { // делегируем к вю контролеру
    viewController?.tableView.delegate = self //
    viewController?.tableView.dataSource = self
  }
  func sendButtonClicked(with text: String?) { // кнопка отправить
    guard let chat = self.chat else {
      return
    }
    guard let text = text, !text.isEmpty  else {// если текст есть и он не пустой
      return
    }
    let message = Message.init(text: text)
    ChatManager.shared.send(message: message, on: chat)
    viewController?.textField.text = nil // очистить текст филд
  }
}
extension ChatController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension // автоматическое расширение ячейки
  }
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
extension ChatController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = dataProvider.message(by: indexPath)
    let identifier = TextMessageTableViewCell.nibName(isOponent: message.isSenderOponent)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextMessageTableViewCell
    cell.configure(by: message)
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.numberOfRows()
  }
}
extension ChatController: Lifecyclable {
  func viewDidAppear() {
  }
  func viewDidLoad() {
    registerCells()
    delegating()
    startObservingMessages()
  }
  func viewWillAppear() {
  }
}
