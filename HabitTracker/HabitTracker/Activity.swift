//
//  Activity.swift
//  HabitTracker
//
//  Created by Dopheide,Pieter on 06/05/2024.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var timesCompleted = 0
}
