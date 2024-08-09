//
//  RememberMeApp.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import SwiftData
import SwiftUI

@main
struct RememberMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
