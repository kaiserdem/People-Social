//
//  PhotoView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class PhotoView: UIView {
  
  private let imageView = UIImageView()
  private let lable = UILabel()
  private let plusView = UIImageView()

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    Decorator.layoutSubviews(self)
    addPlussView()
//    addImageView()
//    addLable()
  }
  private func addLable() {
    lable.text = "Photo"
    lable.translatesAutoresizingMaskIntoConstraints = false
    lable.textAlignment = .center
    lable.font = UIFont.systemFont(ofSize: 12)
    lable.textColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
    addSubview(lable)
    lable.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    lable.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    
    //let constraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[lable]|,V:|-45-[lable]", dict: ["lable": lable])
    //addConstraints(constraints)
  }
  
  private func addImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    addSubview(imageView)
    imageView.heightAnchor.constraint(equalToConstant: 10)
    imageView.widthAnchor.constraint(equalToConstant: 30)
    
    //let constraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[imageView]|,V:[imageView]|", dict: ["imageView": imageView])
    //addConstraints(constraints)
  }
  private func addPlussView() {
    plusView.translatesAutoresizingMaskIntoConstraints = false
    plusView.contentMode = .scaleAspectFill
    plusView.tintColor = #colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1)
    plusView.image = #imageLiteral(resourceName: "plus")
    addSubview(plusView)
    plusView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    plusView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    plusView.widthAnchor.constraint(equalTo: plusView.heightAnchor).isActive = true
    plusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    //let constraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[plusView]|,V:|-15-[plusView(\(frame.height * 0.4))][lable]", dict: ["lable": lable, "plusView": plusView])
    //addConstraints(constraints)
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
      view.imageView.round()

    }
  }
}
