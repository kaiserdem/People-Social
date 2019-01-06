//
//  CellHeaderProtocol.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 06.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation

protocol CellHeaderProtocol {
  associatedtype CellType
  var cellModels:[CellType] { get }
}
