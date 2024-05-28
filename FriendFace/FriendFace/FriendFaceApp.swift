//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Dopheide,Pieter on 21/05/2024.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
