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
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var crossImageView: UIImageView!
  
    private let model = CreatePostModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Decorator.decorate(vc: self)
    textView.delegate = self
    addTargets()
    addGestures()
    clear()
  }
}
extension CreatePostViewController: UITextViewDelegate{
  
  func textViewDidChange(_ textView: UITextView) { // текст был изменен
    let text = textView.text
    model.set(text: text)
  }
}
private extension CreatePostViewController {
  
// настраивает UI данные внутри модели
  private func set(image: UIImage?) {
    updatePostImageView(image: image)
    model.set(image: image)
  }
  private func clear() { // очистить окно после полтверждения
    set(image: nil)
    textView.text = nil // убрать текст
    textView.resignFirstResponder() // закрыть текст фю
  }
  func addTargets() { // кнопка добавить пост
    doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
  }
  func addGestures() { // распознаватель жестов
    let postImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(postImageClicked))
    postImageView.addGestureRecognizer(postImageTapGesture)
    
    let crossTapGesture = UITapGestureRecognizer(target: self, action: #selector(crosstImageClicked))
    crossImageView.addGestureRecognizer(crossTapGesture)
  }
  
  @objc func postImageClicked() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @objc func crosstImageClicked() {
    updatePostImageView(image: nil)
  }
  
  @objc func doneButtonClicked() {
    guard let user = AuthManager.shared.currentUser  else {
      showAlert(with: "Error", and: "User not logged in") // если нет
      return
    }
    PostManager.shared.createPost(from: user, with: model) { (result) in
      switch result {
      case .error(let textError):
        self.showAlert(with: "Error", and: textError)
      case .success:
        self.clear() // стереть
        self.showAlert(with: "Success", and: "Post has been created")
      }
    }
  }
  func updatePostImageView(image: UIImage?) { // звгрузить картинку из поста
    guard let image = image else {  // загрузка удалась
      postImageView.image = #imageLiteral(resourceName: "tap_button.png") //
      crossImageView.isHidden = true
      return
    }
    crossImageView.isHidden = false
    postImageView.image = image
  }
}
private extension CreatePostViewController {
  final class Decorator {
    static func  decorate(vc: CreatePostViewController) {
      vc.postImageView.isUserInteractionEnabled = true
      vc.crossImageView.isUserInteractionEnabled = true
      vc.textView.placeholder = "Add post message..."
    }
  }
}
extension CreatePostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      set(image: editedImage)
    } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      set(image: image)
    }
  }
}
