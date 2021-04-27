//
//  Node.swift
//  Game Of Life Combine
//
//  Created by Justin Purnell on 4/26/21.
//

import Foundation

struct Node: Equatable {
    let x: Int
    let y: Int
    var location: (Int, Int) { return (x, y)}

    var iteration: Int = 0
    var alive: Bool = false

    init(_ x: Int, _ y: Int, _ iteration: Int = 0, _ alive: Bool = false) {
        self.x = x
        self.y = y
        self.iteration = iteration
        self.alive = alive
    }

    func neighbors() -> [(x: Int, y: Int)] {
        var neighbors: [(x: Int, y: Int)] = []
        for x in -1...1 {
            for y in -1...1 {
                neighbors.append((self.x + x, y: self.y + y))
            }
        }
        return neighbors.filter({$0.x >= 0 && $0.y >= 0}).filter({!($0.x == self.x && $0.y == self.y)})
    }
    
    func living() -> String {
        if self.alive == true {
            return "🟩"
        } else {
            return "🟥"
        }
    }
}


func checkNode(_ node: Node, in neighborhood: [Node]) -> Node {
    let coordinatesToCheck = node.neighbors()
    var livingNeighbors: [Node] = []
    for coordinate in coordinatesToCheck {
        guard let neighbor = neighborhood.first(where: {$0.x == coordinate.x && $0.y == coordinate.y}) else { continue }
        if neighbor.alive == true {
            livingNeighbors.append(neighbor)
        }
    }
    let count = livingNeighbors.count

    switch count {
        case 0, 1, 4, 5, 6, 7, 8:
            return Node(node.x, node.y, node.iteration + 1, false)
        case 2:
            return Node(node.x, node.y, node.iteration + 1, true)
        case 3:
            if node.alive == false {
                return Node(node.x, node.y, node.iteration + 1, true)
            } else {
                return Node(node.x, node.y, node.iteration + 1, false)
        }
        default:
            return Node(node.x, node.y, node.iteration + 1, node.alive)
    }
}
