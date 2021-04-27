//
//  Metronome.swift
//  Game Of Life Combine
//
//  Created by Justin Purnell on 4/26/21.
//

import Foundation
import Combine

class Metronome: ObservableObject {
    @Published var ticker = PassthroughSubject<Void, Never>()
    private var tickerSubscription: AnyCancellable?
    
    init() {
        start()
    }
    
    func start(every interval: TimeInterval = 1.0) {
       tickerSubscription = Timer
            .publish(every: interval,
                     on: RunLoop.main,
                     in: RunLoop.Mode.common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.next()
            }
    }
    
    func stop() {
        tickerSubscription?.cancel()
    }
    
    func next() {
        ticker.send()
    }
}
