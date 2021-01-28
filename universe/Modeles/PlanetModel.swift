//
//  Planet.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//

import Foundation

protocol Tobe_PlanetYouNeed{
    var temperature: Int { get set }
    var radius: Int { get set }
}

//MARK: - Planet
class Planet: Tobe_SpaceObjectYouNeed, Tobe_PlanetYouNeed, PSObjectsProtocol {

//MARK: - Arrays, Borowed properties
    unowned var planeterySystem: PlanetarySystem?
    weak var delegatePlanetVC: PlanetVC?
    var allSatelites: [Satelites] = []

//MARK: - Tobe_SpaceObjectYouNeed
    var ID: String = { "Planet|||" + String.random() }()
    var age: Int = 0
    lazy var weight: Int = Int.random(in: 3...5)
    lazy var totalWeight: Int = findTotalWeight()

//MARK: Tobe_PlanetYouNeed, Own properties
    var temperature: Int = Int.random(in: -200...100)
    var radius: Int = Int.random(in: 4...8)
    var amountOfSatelites = Int.random(in: 0...5)


    init(parentPlanetarySystem: PlanetarySystem) {
        self.planeterySystem = parentPlanetarySystem
    }

    func addSatelite() {
        while amountOfSatelites != 0 {
            self.allSatelites.append(.init(parentPlanet: self))
            amountOfSatelites -= 1
        }
    }

    func findTotalWeight() -> Int {
        var sum = 0
        for satelite in allSatelites{
            sum += satelite.weight
        }
        return sum + self.weight
    }

//MARK: adding Satelites
    func timePassed(_ amount: Int) {
        age += 1
        addSatelite()
        for satelite in allSatelites {
            satelite.timePassed(amount)
        }
    }
}

