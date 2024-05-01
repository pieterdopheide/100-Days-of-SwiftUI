//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Dopheide,Pieter on 01/05/2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
