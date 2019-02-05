//
//  CustomSegmentedItemView.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 05.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class CustomSegmentedItemView: UIView { // вю для сегмент контрола
  
  private let titleTrailingConstant: CGFloat = -14
  private let animateDuration: TimeInterval = 0.25 // длительность анимации
  private var model: CustomSegmentedControll.Item?
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.tintColor = .white
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    return label
  }()
  // MARK: Dynamic constraints
  private lazy var labelWidthConstraint = titleLabel.widthAnchor.constraint(equalToConstant: 70)
  private lazy var labelTrailingCostraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: titleTrailingConstant)
  
  var touched: VoidClosure?
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    addImageView()
    addTitleView()
    backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    touched?()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 9 // закруглили 
  }
  
  func configure(by model: CustomSegmentedControll.Item) {
    self.model = model
    imageView.image = model.image
    titleLabel.text = model.title
    adjustLabelWidth(by: model)
  }
  // регулировать высоту
  private func adjustLabelWidth(by model: CustomSegmentedControll.Item) {
    let validWidthForLabel = ContentWidth(content: model.title, copyLable: titleLabel).width
    labelWidthConstraint.constant = validWidthForLabel
    self.labelTrailingCostraint.constant = titleTrailingConstant

  }
  func show() { // когда выбрата
    guard let model = self.model else {
      return
    }
    UIView.animate(withDuration: animateDuration) {
      self.adjustLabelWidth(by: model)
      self.imageView.tintColor = .white
      self.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
      self.layoutIfNeeded()
    }
  }
  
  func hide() { // не выбрана
    UIView.animate(withDuration: animateDuration) {
      self.labelWidthConstraint.constant = 0
      self.labelTrailingCostraint.constant = 0
      self.imageView.tintColor = .black
      self.backgroundColor = .clear
      self.layoutIfNeeded()
    }
  }
  private func addImageView() {
    addSubview(imageView)
    
    let verticalHorizontalConstraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|-12-[imageView],V:|-8-[imageView(17)]-8-|", dict: ["imageView" : imageView])
    let aspectRatioConstraints = [NSLayoutConstraint.quadroAspect(on: imageView)]
    addConstraints(verticalHorizontalConstraints + aspectRatioConstraints)
  }
  
  private func addTitleView() {
    addSubview(titleLabel)
    
    let verticalHorizontalConstraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:[imageView]-12-[label],V:|-8-[label]-8-|", dict: ["imageView": imageView, "label": titleLabel])
    addConstraints(verticalHorizontalConstraints)
    labelWidthConstraint.isActive = true
    labelTrailingCostraint.isActive = true
  }
}
