//
//  PlaneterySystem.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//

import Foundation


protocol PSObjectsProtocol: class {
    var ID: String { get set }
}

protocol PlanetarySystemDelegate: class {
    func destroyPlanetarySystem(_ planetarySys: PlanetarySystem)
}

protocol Tobe_PlanetarySystemYouNeed {
    func addNewStar()
    func addNewPlanet()
}

class PlanetarySystem: Tobe_SpaceObjectYouNeed, Tobe_PlanetarySystemYouNeed, starBecameBlackHoleDelegate, HolesAndSystemesProtocol, PSObjectsProtocol {

//MARK: - Arrays, Borowed properties
    var allPlanetes: [Planet] = []
    var allStars: [Star] = []
    var allObjectsOfPS: [PSObjectsProtocol] = []
    weak var star: Star?
    weak var delegatePlanetarySysVC: PlanetarySystemVC?
    weak var delegatePS: PlanetarySystemDelegate?

//MARK: - Tobe_SpaceObjectYouNeed
    var ID: String = { "System||" + String.random() }()
    var age: Int = 0
    var weight: Int = 0
    lazy var totalWeight = findTotalWeight()


    init(delegate: PlanetarySystemDelegate) {
        self.delegatePS = delegate
        addNewStar()
    }

    func addNewStar() {
        self.allStars.append(Star(delegate: self))
    }

    func addNewPlanet() {
        self.allPlanetes.append(Planet.init(parentPlanetarySystem: self))
    }

    func IamBlackHole(_ star: Star) {
        delegatePS?.destroyPlanetarySystem(self)
    }

    func findTotalWeight() -> Int{

        var sum = 0
        for planet in allPlanetes {
            sum += planet.totalWeight
        }
        for star in allStars {
            sum += star.totalWeight
        }

        return sum + weight
    }

//MARK: - addingPlanets and reloadData
    func timePassed(_ amount: Int) {

        self.age += 1

        if age % 10 == 0 && allPlanetes.count < 9 {
            addNewPlanet()
        }

        for star in allStars {
            star.timePassed(amount)
        }

        for planet in allPlanetes {
            planet.timePassed(amount)
        }

        delegatePlanetarySysVC?.giveAllObjecetsOfPS()
    }
}
