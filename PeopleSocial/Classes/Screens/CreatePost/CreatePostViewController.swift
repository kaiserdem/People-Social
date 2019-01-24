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

  
  private var tapToAddPostImage = #imageLiteral(resourceName: "tap_button")
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      Decorator.decorate(vc: self)
      addTargets()
      addGestures()
      updatePostImageView(image: tapToAddPostImage)
    }
}
private extension CreatePostViewController {
  
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
    updatePostImageView(image: tapToAddPostImage)
  }
  
  @objc func doneButtonClicked() {
    guard let user = AuthManager.shared.currentUser  else {
      showAlert(with: "Error", and: "User not logged in") // если нет
      return
    }
    _ = postImageView.image != #imageLiteral(resourceName: "tap_button.png") ? postImageView.image : nil
    
      PostManager.shared.createPost(from: user, with: textView.text, completion: { (result) in
        switch result {
        case .error(let textError):
          self.showAlert(with: "Error", and: textError)
        case .success:
          self.showAlert(with: "Success", and: "Post has been created")
        }
    })
  }
  func updatePostImageView(image: UIImage) {
    postImageView.image = image
    crossImageView.isHidden = image == tapToAddPostImage
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
      updatePostImageView(image: editedImage)
    } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      updatePostImageView(image: image)
    }
  }
}
