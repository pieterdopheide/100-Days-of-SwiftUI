//
//  Person.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import CoreLocation
import Foundation
import SwiftData
import SwiftUI

@Model
class Person: Identifiable, Hashable {
    var id = UUID()
    var name: String
    @Attribute(.externalStorage) var photo: Data
    var location: Coordinate2D?
    
    var photoImage: Image {
        if let uiImage = UIImage(data: self.photo) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person")
        }
    }
    
    init(id: UUID = UUID(), name: String, photo: Data, location: Coordinate2D?) {
        self.id = id
        self.name = name
        self.photo = photo
        self.location = location
    }
}

struct Coordinate2D: Codable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Coordinate2D {
    init(_ location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
