//
//  PersonDetailView.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var person: Person
    
    var body: some View {
        NavigationStack {
            VStack {
                person.photoImage
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                if let location = person.location {
                    let startPosition = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: location.location,
                            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
                        )
                    )
                    
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            Annotation("Placeholder", coordinate: location.location) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(role: .destructive) {
                    modelContext.delete(person)
                    dismiss()
                } label: {
                    Label("Delete person", systemImage: "xmark")
                }
            }
            .navigationTitle(person.name)
        }
    }
}

#Preview {
    PersonDetailView(person: Person(name: "John Doe", photo: UIImage(systemName: "person")!.pngData()!, location: nil))
}
