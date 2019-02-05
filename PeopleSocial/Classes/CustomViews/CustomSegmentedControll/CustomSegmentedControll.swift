//
//  CustomSegmentedControll.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 05.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class CustomSegmentedControll: UIControl { // создали свой сегмент контрол
  struct Item {
    var title: String
    var image: UIImage
  }
  private let statView: UIStackView = UIStackView()
  private var items: [Item] = []
  // private(set)кроме класса ни где не меняеться
  private(set) var selectedIndex = 0 { // по дефолту
    didSet {     // когда индекс изменился
      sendActions(for: .valueChanged)
      selectAnimated(index: selectedIndex)
    }
  }
  
  convenience init(items: [Item]) { // инициализировали масив Item
    self.init()
    self.items = items
  }
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    addStackView()
    addViews()
    selectAnimated(index: selectedIndex)
  }
  private func addStackView() {
    statView.translatesAutoresizingMaskIntoConstraints = false
    statView.spacing = 0
    statView.distribution = .equalSpacing
    statView.axis = .horizontal
    statView.alignment = .leading
    addSubview(statView)
    let constarints = NSLayoutConstraint.constrains(withNewVisyalFormat: "H:|[v]|,V:|[v]|", dict: ["v" : statView])
    addConstraints(constarints)
  }
  private func selectAnimated(index: Int) { // вызвать анимацию вю
    statView.arrangedSubviews.enumerated().forEach { (i, view) in
      if let itemView = view as? CustomSegmentedItemView {
        i == index ? itemView.show() : itemView.hide() // показать или спрятать
      }
    }
  }
  private func addViews() {
    items.enumerated().forEach { (i, model) in  // получить индекст елемента в цикле
      let itemView = CustomSegmentedItemView()
      itemView.touched = {
        self.selectedIndex = i
      }
      itemView.configure(by: model)
      statView.addArrangedSubview(itemView)
    }
  }
}
