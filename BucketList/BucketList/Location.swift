//
//  Location.swift
//  BucketList
//
//  Created by Dopheide,Pieter on 19/06/2024.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Huis ten Bosch", description: "Its Orange Hall is famous because of its many paintings.", latitude: 52.0934239, longitude: 4.3443689)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
