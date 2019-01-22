//
//  Utilites.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 07.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

func ID() -> String { // задаем айдти пользователя
  let str = "asdfghjklpoiuytrewqzxcvbnm1234567890"
  let arr = Array(str)
  
  func random() -> String { // рандомный масив строк для айди
    return String(describing: arr[Int.random(in: arr.indices)])
  }
  var result = ""
  let  countCharacters = 24
  for _ in 0..<countCharacters {
    result += random()
  }
  return result
}

public func onMain(block: @escaping () -> Void) { // на главном потоке выполняеться блок
  DispatchQueue.main.async {
    block()
  }
}
