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

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Enter"
      addRightButton()
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
    AuthManager.shared.singIn(with: email, and: password) { (result) in
      switch result {
      case .success:
        self.showAlert(with: "Ready", and: "Are you entered")
      case .error(let error):
        self.showAlert(with: "Error", and: error)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // большие буквы нав контроллера
     navigationController?.navigationBar.prefersLargeTitles = true
    // показать нав контроллер
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  
}
