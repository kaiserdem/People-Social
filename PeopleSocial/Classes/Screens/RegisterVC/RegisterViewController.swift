//
//  RegisterViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, NibLoadable {

  private var models: [CellModel] = [.userInfo]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    title = "Registration"
    registerCells()
    delegating()

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) // приячим навигейшен бар
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func delegating() { //подписали делегаты
    tableView.delegate = self
    tableView.dataSource = self
  }
  private func registerCells() { // регистрируем ячейку
    tableView.register(InfoUserTableViewCell.nib, forCellReuseIdentifier: InfoUserTableViewCell.name)
  }

}
extension RegisterViewController {
  fileprivate enum CellModel { // модель ячеек
    case userInfo
    case sex
    case bithday
  }
}
extension RegisterViewController: UITableViewDelegate {
  // высота для ячейки
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let model = models[indexPath.row]
    switch model {
    case .userInfo: return 100
    default: return 0
    }
  }
}

extension RegisterViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    switch model {
    case .userInfo:
      if let cell = tableView.dequeueReusableCell(withIdentifier: InfoUserTableViewCell.name, for: indexPath) as? InfoUserTableViewCell {
        return cell
      }
    default: break
    }
    return UITableViewCell()
  }
}
