//
//  BlackHoleModel.swift
//  universe
//
//  Created by 1 on 19.01.2021.
//

import Foundation

class BlackHole: HolesAndSystemesProtocol {

    var ID: String
    
    init() {
        self.ID = "Hole||" + String.random()
    }
}
