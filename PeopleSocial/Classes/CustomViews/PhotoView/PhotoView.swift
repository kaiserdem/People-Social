//
//  PhotoView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PhotoView: UIView {
  
  private var imageView = UIImageView()
  private let lable = UILabel()
  private let plusView = UIImageView()
  private let button = UIButton()

  var clicked: VoidClosure? // кложер вызывает
  
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    Decorator.decorator(self)
    
    addPlussView()
    addImageView()
    addLable()
    clipsToBounds = true // круглая вю

  }
  //касание было окончено
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    clicked?()
    lable.isHidden = true // скрыть лейбл

  }
  
  func set(image: UIImage?) { // задать картинку
    imageView.image = image
    imageView.isHidden = image == nil // выключен когда image (равно) == nil
  }
  
  private func addImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true // изначально не видна на экране
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    addSubview(imageView)
    
    //imageView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    //imageView.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
    let constraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[imageView]|,V:|[imageView]|", dict: ["imageView" : imageView])
    addConstraints(constraints)
  }
  
  private func addLable() {
    lable.text = "Photo"
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.textAlignment = .center
    lable.font = UIFont.systemFont(ofSize: 12)
    lable.textColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
    addSubview(lable)
    
    lable.leftAnchor.constraint(equalTo: plusView.leftAnchor, constant: -7).isActive = true
    lable.topAnchor.constraint(equalTo: plusView.bottomAnchor, constant: 2).isActive = true
    lable.widthAnchor.constraint(equalToConstant: 40).isActive = true
  }
  private func addPlussView() {
    plusView.translatesAutoresizingMaskIntoConstraints = false
    plusView.contentMode = .scaleAspectFill
    plusView.tintColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
    plusView.image = #imageLiteral(resourceName: "plus")
    addSubview(plusView)
    
    plusView.leftAnchor.constraint(equalTo: leftAnchor, constant: 26).isActive = true
    plusView.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
    plusView.widthAnchor.constraint(equalToConstant: 27).isActive = true
    plusView.heightAnchor.constraint(equalTo: plusView.widthAnchor).isActive = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    Decorator.layoutSubviews(self)
  }
}

extension PhotoView {
  
  fileprivate final class Decorator {
    static func decorator(_ view: PhotoView) {
      view.layer.borderColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
      view.layer.borderWidth = 1
    }
    static func layoutSubviews(_ view: PhotoView) {
      view.round()
      view.backgroundColor = .white
    }
  }
}
