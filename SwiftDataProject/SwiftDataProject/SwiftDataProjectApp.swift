//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Dopheide,Pieter on 14/05/2024.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
