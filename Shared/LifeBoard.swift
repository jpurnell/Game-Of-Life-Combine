//
//  LifeBoard.swift
//  Game Of Life Combine
//
//  Created by Justin Purnell on 4/26/21.
//

import Foundation
import Combine

class LifeBoard: ObservableObject {
    @Published private(set) var result: String = ""
    @Published private(set) var inter: [Node] = []
    lazy private(set) var sharedBoard: AnyPublisher<[Node], Never> = $inter
        .share()
        .eraseToAnyPublisher()
    var description: String { return "\(self.board.map({$0.living()}).joined())\n".separate(every: self.width, with: "\n")}
    @Published private(set) var board: [Node] = []
    let metronome = Metronome()
    let width: Int
    let height: Int
    
    func setupBoard(width: Int = 8, height: Int = 8) -> [Node] {
        var board: [Node] = []
        for x in 0..<width {
            for y in 0..<height {
                board.append(Node(x, y))
            }
        }
        
        for i in 0..<(width * height) {
            board[i].alive = Bool.random()
        }
        return board
    }

    
    init(_ width: Int = 8, _ height: Int = 8) {
        self.width = width
        self.height = height
        self.board = setupBoard(width: width, height: height)
        self.metronome.start()
        self.result = ""
    }
    
    func start() {
        resultString()
        updateInter()
        updateBoard()
    }
    
    func stop() {
        
    }
    
    func updateInter() {
        $board
            .delay(for: 0.5, scheduler: RunLoop.main)
            .print("Update Inter\n")
            .map({ nodeArray in
                let description = "\(nodeArray.map({$0.living()}).joined())\n".separate(every: self.width, with: "\n")
           return nodeArray.map({checkNode($0, in: nodeArray)})
        })
            .assign(to: &$inter)
    }
    
    func resultString() {
        self.sharedBoard
            .dropFirst()
            .print("Result String\n")
            .map({ nodeArray -> String in
                let description = "\(nodeArray.map({$0.living()}).joined())\n".separate(every: self.width ?? 5, with: "\n")
                print(description)
            return description
        })
            .assign(to: &$result)
    }
    
    func updateBoard() {
        self.sharedBoard
            .print("Update Board\n")
            .map({ nodes in
//                if nodes.map({$0.alive == false}).count == nodes.count {
//                    return self.setupBoard()
//                }
                return nodes
        })
        .assign(to: &$board)
    }
    
    
}

