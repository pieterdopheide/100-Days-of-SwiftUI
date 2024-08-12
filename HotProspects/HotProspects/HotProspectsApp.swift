//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Dopheide,Pieter on 12/08/2024.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
