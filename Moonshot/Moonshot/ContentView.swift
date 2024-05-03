//
//  ContentView.swift
//  Moonshot
//
//  Created by Dopheide,Pieter on 03/05/2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isShowingAsGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isShowingAsGrid {
                    MissionsGridView(astronauts: astronauts, missions: missions)
                } else {
                    MissionsListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Toggle(isOn: $isShowingAsGrid) {
                        Text("Grid")
                    }
                    .toggleStyle(.switch)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
