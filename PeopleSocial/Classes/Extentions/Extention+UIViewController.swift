//
//  Extention+UIViewController.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func showAlert(with title: String, and massage: String) { // создаем алерт контроллер
    
    let alertController = UIAlertController(title: title, message: massage, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
}
