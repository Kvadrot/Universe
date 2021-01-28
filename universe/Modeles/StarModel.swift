//
//  Star.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//
import Foundation

protocol starBecameBlackHoleDelegate: class {
    func IamBlackHole(_ star: Star )
}

enum StarEvolutionPhaseEnum: CaseIterable {

    case young
    case old
    case whiteDwarf
    case blackHole
}
enum StarTypesEnum: CaseIterable {

    case yellowDwarf
    case redGiant
    case brownDwarf
}

class Star: Tobe_SpaceObjectYouNeed, PSObjectsProtocol {

//MARK: - Arrays, Borowed properties
    var type: StarTypesEnum = StarTypesEnum.allCases.randomElement()!
    var phaseOfEvolutionEnum: StarEvolutionPhaseEnum = .young
    weak var starDelegate: starBecameBlackHoleDelegate?

//MARK: - Tobe_SpaceObjectYouNeed
    var ID: String = { "Star |||" + String.random() }()
    var age: Int = 0
    var weight: Int = Int.random(in: 1...100)
    lazy var totalWeight = findTotalWeight()
//MARK: -
    var luminosity: Int = Int.random(in: 0...100)
    var radius: Int = Int.random(in: 0...100)


    init(delegate: starBecameBlackHoleDelegate) {
        self.starDelegate = delegate
    }

    func findTotalWeight() -> Int {
        return self.weight
    }

//MARK: - changingStarPhaseEolution
    func timePassed(_ amount: Int) {
        age += 1
        if ((self.age % TimeSettings.every60Sec) == 0) && self.phaseOfEvolutionEnum != .blackHole {
            self.phaseOfEvolutionEnum = StarEvolutionPhaseEnum.next(self.phaseOfEvolutionEnum)()
        }

        if self.totalWeight >= Universe.criticalWeightForStar && self.phaseOfEvolutionEnum == .blackHole {
            let star = self
            starDelegate?.IamBlackHole(star)
        }
        
    }
}

