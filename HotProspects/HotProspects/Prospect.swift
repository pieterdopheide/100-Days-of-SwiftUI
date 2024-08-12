//
//  Prospect.swift
//  HotProspects
//
//  Created by Dopheide,Pieter on 12/08/2024.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var createdDate: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, createdDate: Date = Date.now) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.createdDate = createdDate
    }
}
