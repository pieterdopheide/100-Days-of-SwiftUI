//
//  Card.swift
//  Flashzilla
//
//  Created by Dopheide,Pieter on 19/08/2024.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Docter in Doctor Who?", answer: "Jodie Whittaker")
}
