//
//  File.swift
//  universe
//
//  Created by 1 on 14.01.2021.
//

import Foundation
import UIKit


protocol Tobe_SpaceObjectYouNeed {

    var ID: String { get set }
    var weight: Int { get set }
    var age: Int { get set }

    func findTotalWeight() -> Int
    func timePassed(_ amount: Int)
}
extension Tobe_SpaceObjectYouNeed {

    func timePassed(_ amount: Int){}
}


fileprivate protocol Tobe_UniverseYouNeed {

    func addNewGalaxy()
    func mergeringProcess()
}

protocol UniverseDelegate: class {

    func removeGalaxy()
}

final class Universe: TimerDelegate {

    let timer = UniverseTimer()
    var allGalaxies: [Galaxy] = []
    weak var delegate: ViewController?
    var delegateGalaxyVC: GalaxyVC?
    var universeDelegate: [Galaxy?] = []

//MARK: - massOfStarRebirth
    static var criticalWeightForStar = 81


    init() {
        timer.delegate = self
        //timer.start()
    }

    fileprivate func addNewGalaxy() {
        //allGalaxies.append(.init(parentUniverse: self))
        let galaxyModel = Galaxy()
        galaxyModel.universeDelegate = self
        universeDelegate.append(galaxyModel)
        allGalaxies.append(galaxyModel)
    }

    func mergeringProcess() {
        var ageMatchedGalaxies = checkingMinAmountofGalaxies()
        var randomGalaxyMIN: Galaxy
        var randomGalaxyMAX: Galaxy

        if ageMatchedGalaxies.count >= 2 {
            randomGalaxyMIN = choosingRandomGalaxy(&ageMatchedGalaxies)
            randomGalaxyMAX = choosingRandomGalaxy(&ageMatchedGalaxies)
            weighingGalaxies(&randomGalaxyMIN, &randomGalaxyMAX)

            var newGalaxyAfterMerg: Galaxy = mergeringGalaxies(&randomGalaxyMIN, &randomGalaxyMAX)
            removeGalaxy(&self.allGalaxies, randomGalaxyMIN)
            removeGalaxy(&self.allGalaxies, randomGalaxyMAX)
        }
    }

    func timeChanged(_ amount: Int) {

        if amount % TimeSettings.every10Sec == 0 {
            addNewGalaxy()
        }

        if amount % TimeSettings.every30Sec == 0 {
            mergeringProcess()
        }

        for galaxy in allGalaxies {
            galaxy.timePassed(amount)
        }

        delegate?.giveUniverse()
    }
}

extension Universe {

    func checkingMinAmountofGalaxies() -> [Galaxy] {

        let arrayForChecking = allGalaxies.filter { $0.age >= TimeSettings.aged180 }

        return arrayForChecking
    }

    func choosingRandomGalaxy(_ ageMatchedGalaxies: inout [Galaxy]) -> Galaxy {

        let randomGalaxy: Galaxy = ageMatchedGalaxies.randomElement()!
        ageMatchedGalaxies = removeGalaxy(&ageMatchedGalaxies, randomGalaxy)

        return randomGalaxy
    }

    func weighingGalaxies(_ randomGalaxyMIN: inout Galaxy, _ randomGalaxyMAX: inout Galaxy) {

        var min = randomGalaxyMIN
        var max = randomGalaxyMAX

        let savedRandomGalaxyMIN = min
        var arrayMinMax = [min, max]

        if min.weight > max.weight {

            min = max
            max = savedRandomGalaxyMIN
        } else if max.weight == min.weight{

            min = arrayMinMax.randomElement()!
            removeGalaxy(&arrayMinMax, min)
            max = arrayMinMax[0]
        }
    }

    func removeGalaxy(_ someArray: inout [Galaxy], _ somegalaxy: Galaxy) -> [Galaxy] {

        let galaxy = someArray.first(where: {$0 === somegalaxy})
        galaxy?.removeGalaxy()
        someArray.remove(at: someArray.firstIndex(where: {$0 === somegalaxy})!)

        return someArray
    }

    func mergeringGalaxies(_ randomGalaxyMIN: inout Galaxy, _ randomGalaxyMAX: inout Galaxy ) -> Galaxy {

        //MARK:  - lossPercentages of planetarySystemes
        let percent: Double = 10

        let newGalaxyAfterMerg = randomGalaxyMAX
        newGalaxyAfterMerg.ID = String.random()
        newGalaxyAfterMerg.allPlanetarySystemes.append(contentsOf: randomGalaxyMIN.allPlanetarySystemes)

        var sysForDeleting = round( Double( newGalaxyAfterMerg.allPlanetarySystemes.count) / 100 * percent)

            while sysForDeleting != 0 {
                guard let randomSys = newGalaxyAfterMerg.allPlanetarySystemes.randomElement() else { break }

                newGalaxyAfterMerg.removePlanetarySystem(&newGalaxyAfterMerg.allPlanetarySystemes, randomSys)
                    sysForDeleting -= 1
        }

        return newGalaxyAfterMerg
    }
}
