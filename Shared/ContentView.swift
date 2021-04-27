//
//  ContentView.swift
//  Shared
//
//  Created by Justin Purnell on 4/26/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var board = LifeBoard()
    
    var body: some View {
        VStack {
            Text(board.description)
                .padding()
            HStack {
                Button("Start") { board.start() }
                Button("Stop") { board.start() }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
