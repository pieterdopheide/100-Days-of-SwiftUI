//
//  AddPersonView.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import CoreLocation
import SwiftUI

struct AddPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var selectedImage: Data
    
    let locationFetcher = LocationFetcher()
    
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                photoImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var location: Coordinate2D? = nil
                        if let currentLocation = locationFetcher.lastKnownLocation {
                            location = Coordinate2D(currentLocation)
                        }
                        
                        let person = Person(name: name, photo: selectedImage, location: location)
                        modelContext.insert(person)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear() {
                locationFetcher.start()
            }
        }
    }
    
    func photoImage() -> Image {
        if let uiImage = UIImage(data: selectedImage) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person")
        }
    }
}

#Preview {
    AddPersonView(selectedImage: UIImage(systemName: "person")!.pngData()!)
}
