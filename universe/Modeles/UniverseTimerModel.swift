//
//  TimerModel.swift
//  universe
//
//  Created by 1 on 16.01.2021.
//

import Foundation

protocol TimerDelegate: class {
    func timeChanged(_ amount: Int)
}

final class UniverseTimer {

    private var timer: Timer?
    private var time: Int = 0
    var delegate: TimerDelegate?
    var intervalForTimer = 1

    func start() {
        self.timer = .scheduledTimer(timeInterval: TimeInterval(intervalForTimer),
                                     target: self, selector: #selector(didTick),
                                     userInfo: nil, repeats: true)
    }

    @objc func didTick() {
        time += 1
        delegate?.timeChanged(time)
    }
}
