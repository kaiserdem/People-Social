//
//  LoginViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private let models: [CellModel] = [.email, .password] // масив модели
  private var loginModel: LoginModel = LoginModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addRightButton()
    delegating()
    addTargets()
    Decorator.decorate(self)
    registerCell()
    addHeaderView()
    addFooterView()
  }
  private func delegating() {
  tableView.delegate = self
  tableView.dataSource = self
  }
  private func addHeaderView() { // добавить титул, верхний елемент
    let headerView = TitleHeaderView.loadFromNib()
    let height: CGFloat =  100
    let width = view.frame.size.width
    headerView.frame.size = CGSize(width: width, height: height)
    tableView.tableHeaderView = headerView
  }
  private func  addFooterView() { // нижний елемент
    let foorerView = TextFooterView.loadFromNib()
    foorerView.frame.size.width = view.frame.width
    foorerView.set(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut pretium pretium tempor. Ut eget")
    tableView.tableFooterView = foorerView
  }
  private func registerCell() { // регистрация ячейки
    tableView.register(DetailFieldTableViewCell.nib, forCellReuseIdentifier: DetailFieldTableViewCell.name)
  }
  
  private func addRightButton() { // правая кнопка
    let button = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(rightButtonClicked))
      navigationItem.rightBarButtonItem = button // на правую сторону
  }
  @objc private func rightButtonClicked() {
    let email = loginModel.email ?? "" // есть ли текст
    let password = loginModel.password ?? ""

    guard !email.isEmpty && !password.isEmpty else { // если пустые
      showAlert(with: "Error", and: "Fill in the fields")
      return
    }// в противном случае, если все хорошо
    self.performLogin(email: email, password: password)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // большие буквы нав контроллера
     navigationController?.navigationBar.prefersLargeTitles = false
    // показать нав контроллер
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  // текст изменен, принимает модель и текст
  func textChanged(with model: CellModel, and text: String) {
    switch model { // какая модель изменилась
    case .email: self.loginModel.email = text
    case .password: self.loginModel.password = text
    }
  }
}
extension LoginViewController {
  enum CellModel { // модель елементов
    case email
    case password
    
    var plaseholder: String? {
      switch self {
      case .email: return "Your email"
      case .password: return "Your password"
      }
    }
    var title: String? {
      switch self {
      case .email: return "Email"
      case .password: return "Password"
      }
    }
  }
}
extension LoginViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return DetailFieldTableViewCell.heigth
  }
}
extension LoginViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DetailFieldTableViewCell.name, for: indexPath) as! DetailFieldTableViewCell
    let model = models[indexPath.row]
    cell.adjustWidth(by: models.map{ $0.title ?? ""}) 
    cell.set(placeholder: model.plaseholder)
    cell.set(title: model.title)
    let insets = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
    switch model {
    case .email:
      cell.addSeparator(on: .top, insets: insets)
      cell.set(secure: false)
      cell.activeTextField()
    case .password:
      cell.addSeparator(on: .boottom, insets: insets)
      cell.set(secure: true)
    }
    cell.textChanged = { // возвращает текст
      text in
      self.textChanged(with: model, and: text)
    }
    return cell
  }
}
private extension LoginViewController {
  final class Decorator {
    static func decorate(_ vc: LoginViewController) {
      
      vc.navigationController?.navigationBar.makeClear() // прозрачный нав бар
      
//      let biometricType = BiometricAuthManager.shared.biometricType()
//      switch biometricType {
//      case .touchID:
//        vc.authButton.setImage(#imageLiteral(resourceName: "touchId"), for: .normal)
//      case .faceID:
//        vc.authButton.setImage(#imageLiteral(resourceName: "faceId"), for: .normal)
//      case .none:
//        vc.authButton.setImage(#imageLiteral(resourceName: "touch_id"), for: .normal)
//        vc.authButton.isEnabled = false
 //     }
    }
  }
}

private extension LoginViewController {
  func addTargets() {
//    authButton.addTarget(self, action: #selector(authButtonClicked), for: .touchUpInside)
  }
  
  func performLogin(email: String?, password: String?) { // выполнить вход
    AuthManager.shared.singIn(with: email, and: password) { (result) in
      switch result {
      case .success:
         StartRouter.shared.routeAfterSuccess(from: self)
      case .error(let error):
        self.showAlert(with: "Error", and: error)
      }
    }
  }
  
  @objc func authButtonClicked() {
    BiometricAuthManager.shared.authenticateUser { (error) in
      if let error = error {
        self.showAlert(with: "Error", and: error.errorDescription ?? "Unexpected result")
        return
      }
      let userInfo = SecureStorageManager.shared.loadEmailAndPassword()
      self.performLogin(email: userInfo.email, password: userInfo.password)
    }
  }
}
