//
//  RollLog.swift
//  Dice
//
//  Created by Dopheide,Pieter on 01/10/2024.
//

import Foundation
import SwiftData

@Model
class RollLog {
    var id = UUID()
    var results: [Int]
    var diceType: String
    var dateRolled = Date.now
    
    var diceRolled: Int { results.count }
    var total: Int { results.reduce(0, +) }
    
    init(id: UUID = UUID(), results: [Int], diceType: String, dateRolled: Date = .now) {
        self.id = id
        self.results = results
        self.diceType = diceType
        self.dateRolled = dateRolled
    }
}
