//
//  Person.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Person: Identifiable, Hashable {
    var id = UUID()
    var name: String
    @Attribute(.externalStorage) var photo: Data
    
    var photoImage: Image {
        if let uiImage = UIImage(data: self.photo) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person")
        }
    }
    
    init(id: UUID = UUID(), name: String, photo: Data) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
