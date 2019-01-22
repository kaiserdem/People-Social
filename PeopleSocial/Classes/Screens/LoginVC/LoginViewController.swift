//
//  LoginViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  @IBOutlet weak var authButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Enter"
      addRightButton()
      
      addTargets()
      Decorator.decorate(self)
  }
  private func addRightButton() { // правая кнопка
    let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked))
      navigationItem.rightBarButtonItem = button // на правую сторону
  }
  @objc private func doneButtonClicked() {
    let email = emailTextField.text ?? "" // есть ли текст
    let password = passwordTextField.text ?? ""
    
    guard !email.isEmpty && !password.isEmpty else {
      showAlert(with: "Error", and: "Fill in the fields")
      return
    }
    self.performLogin(email: email, password: password)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // большие буквы нав контроллера
     navigationController?.navigationBar.prefersLargeTitles = true
    // показать нав контроллер
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
}
private extension LoginViewController {
  final class Decorator {
    static func decorate(_ vc: LoginViewController) {
      let biometricType = BiometricAuthManager.shared.biometricType()
      switch biometricType {
      case .touchID:
        vc.authButton.setImage(#imageLiteral(resourceName: "touchId"), for: .normal)
      case .faceID:
        vc.authButton.setImage(#imageLiteral(resourceName: "faceId"), for: .normal)
      case .none:
        vc.authButton.setImage(#imageLiteral(resourceName: "touch_id"), for: .normal)
        vc.authButton.isEnabled = false
      }
    }
  }
}

private extension LoginViewController {
  func addTargets() {
    authButton.addTarget(self, action: #selector(authButtonClicked), for: .touchUpInside)
  }
  
  func performLogin(email: String?, password: String?) {
    AuthManager.shared.singIn(with: email, and: password) { (result) in
      switch result {
      case .success:
        self.showAlert(with: "Successfully", and: "You are logged in")
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
