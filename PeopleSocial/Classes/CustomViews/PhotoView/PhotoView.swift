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

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    Decorator.decorator(self)
    
    addPlussView()
    addImageView()
    addLable()
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
  
  private func addImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    addSubview(imageView)
    
    //imageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    //imageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
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
