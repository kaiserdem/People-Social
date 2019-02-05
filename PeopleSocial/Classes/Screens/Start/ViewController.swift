//
//  ViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var singInButton: UIButton!
  @IBOutlet weak var registerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Decorator.decorator(_vc: self)
    addTargets()
    
    let item = CustomSegmentedControll.Item(title: "Men", image: UIImage(named: "mars")!)
    let item1 = CustomSegmentedControll.Item(title: "Momen", image: UIImage(named: "femenine")!)

    let segmentedControll = CustomSegmentedControll(items: [item, item1])
    segmentedControll.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(segmentedControll)
    
    let constraints = NSLayoutConstraint.constrains(withNewVisyalFormat: "V:|-150-[v],H:|[v]", dict: ["v" : segmentedControll])
    self.view.addConstraints(constraints)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)// приячим навигейшен бар
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  private func addTargets() {
    singInButton.addTarget(self, action: #selector(singInButtoClicked), for: .touchUpInside)
    registerButton.addTarget(self, action: #selector(registerButtoClicked), for: .touchUpInside)
  }
  
  @objc private func singInButtoClicked() {
    StartRouter.shared.goToLoginScreen(from: self)
  }
  @objc private func registerButtoClicked() {
    StartRouter.shared.goToRegisterScreen(from: self)
  }
}

extension ViewController {
  fileprivate class Decorator {
    static let buttonCornerRadius: CGFloat = 7
    
    private init() {}
    
    static func decorator(_vc: ViewController) {
      _vc.registerButton.layer.cornerRadius = buttonCornerRadius
      _vc.registerButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
  }
  
}
