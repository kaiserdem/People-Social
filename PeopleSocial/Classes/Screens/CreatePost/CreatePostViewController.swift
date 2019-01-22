//
//  CreatePostViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 22.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      addTargets()
    }
  private func addTargets() { // кнопка добавить пост
    doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
  }
  @objc func doneButtonClicked() {
    // заполено ли поле
    guard let text = textView.text, !text.isEmpty else {
      showAlert(with: "Error", and: "Text is empty") // если нет
      return
    }
    // проверка текущего юзера
    guard let user = AuthManager.shared.currentUser else {
      showAlert(with: "Error", and: "User not logged in") // если нет
      return
    }
    PostManager.shared.createPost(from: user, with: text) { (result) in
      switch result {
      case .error(let textError):
        self.showAlert(with: "Error", and: textError)
      case  .success:
        self.showAlert(with: "Success", and: "Post has been created")
      }
    }
  }
}
