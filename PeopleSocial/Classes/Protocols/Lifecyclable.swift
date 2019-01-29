//
//  Lifecyclable.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 27.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation // Жизненный цикл

protocol Lifecyclable {
  func viewDidAppear()
  func viewDidLoad()
  func viewWillAppear()

}
