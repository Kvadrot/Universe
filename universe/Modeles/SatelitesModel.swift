//
//  Setelities.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//

import Foundation

// MARK: - Satelites
class Satelites: Tobe_SpaceObjectYouNeed, Tobe_PlanetYouNeed {

    var ID: String = String.random()
    var weight: Int = Int.random(in: 1...3)
    lazy var totalWeight: Int = findTotalWeight()
    var age: Int


    var temperature: Int = Int.random(in: -200...100)
    var radius: Int = Int.random(in: 1...5)


    init(parentPlanet: Planet) {
        self.age = 0
    }

    func findTotalWeight() -> Int {
        return self.weight
    }
    
    func timePassed(_ amount: Int) {
        age += 1
        }
}
