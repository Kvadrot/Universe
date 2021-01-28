//
//  GalaxyModel.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//

import Foundation

protocol HolesAndSystemesProtocol: class {

    var ID: String { get set }
}

fileprivate protocol Tobe_GalaxyYouNeed {

    func addNewPlanetarySystem()
    func removePlanetarySystem(_ arrayPlanetarySys: inout [PlanetarySystem], _ targetPlanetarySys: PlanetarySystem)
}

//MARK: -Galaxytypes
enum GalaxyTypeEnum: CaseIterable {

    case spiral
    case elliptical
    case irregular 
}

class Galaxy: Tobe_SpaceObjectYouNeed, Tobe_GalaxyYouNeed, PlanetarySystemDelegate, HolesAndSystemesProtocol {

//MARK: - Arrays, Borowed properties
    var type: GalaxyTypeEnum = { GalaxyTypeEnum.allCases.randomElement()! }()
    var allPlanetarySystemes: [PlanetarySystem] = []
    var allBlackHoles: [BlackHole] = []
    var allHolesAndSystemes: [HolesAndSystemesProtocol] = []
//MARK: - Delegates
    weak var universeDelegate: Universe?
    var heroAlertHandler: (() -> Void)?
    var giveAllHolesAndSystemesHandler: (() -> Void)?

    //MARK: - Tobe_SpaceObjectYouNeed
    var ID: String = { "Galaxy|" + String.random() }()
    lazy var weight: Int = 0
    lazy var totalWeight: Int = findTotalWeight()
    var age: Int


    init() {
        self.age = 0
    }

    func addNewPlanetarySystem() {

        self.allPlanetarySystemes.append(PlanetarySystem(delegate: self))
    }

    func removePlanetarySystem(_ arrayPlanetarySys: inout [PlanetarySystem], _ targetPlanetarySys: PlanetarySystem) {

        arrayPlanetarySys.remove(at: arrayPlanetarySys.firstIndex(where: {$0 === targetPlanetarySys})!)
    }

    func findTotalWeight() -> Int {
        var sum = 0
        for planetarySystem in allPlanetarySystemes {
            sum += planetarySystem.totalWeight
        }
        return sum + weight
    }

    func timePassed(_ amount: Int) {

        self.age += 1

        if amount % 10 == 0 {
            addNewPlanetarySystem()
        }
        for planetarySys in allPlanetarySystemes {
            planetarySys.timePassed(amount)
        }
        giveAllHolesAndSystemesHandler?()
    }
}

extension Galaxy {

    func destroyPlanetarySystem(_ planetarySys: PlanetarySystem) {

        removePlanetarySystem(&allPlanetarySystemes, planetarySys)
        addBlackHole()
    }

    func addBlackHole() {

        self.allBlackHoles.append(BlackHole())
    }
}

extension Galaxy: UniverseDelegate {

    func removeGalaxy() {
        heroAlertHandler?()
    }
}
