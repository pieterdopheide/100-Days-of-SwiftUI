//
//  Activities.swift
//  HabitTracker
//
//  Created by Dopheide,Pieter on 06/05/2024.
//

import Foundation

@Observable
class Activities {
    var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
