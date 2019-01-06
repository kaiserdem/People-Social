//
//  Typealias.swift
//  PeopleSocial
//
//  Created by Kaiserdem on 03.01.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
                          // обединили несколько протоколов
typealias StaticCellProtocol = NibLoadable & HeigtContainable

typealias ItemClosure<T> = ((T) -> Void) // дженерик,клоужер  возвращает 

