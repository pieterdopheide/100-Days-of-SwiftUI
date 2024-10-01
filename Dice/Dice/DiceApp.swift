//
//  DiceApp.swift
//  Dice
//
//  Created by Dopheide,Pieter on 27/09/2024.
//

import SwiftData
import SwiftUI

@main
struct DiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RollLog.self)
    }
}
