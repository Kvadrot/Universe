//
//  Extentions.swift
//  universe
//
//  Created by 1 on 15.01.2021.
//

import Foundation


extension String {

    static func random(length: Int = 10) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    func next() -> Self {
            var all = Self.allCases
            let idx = all.firstIndex(of: self)!
            let next = all.index(after: idx)
            return all[next == all.endIndex ? all.startIndex : next]
        }
}
