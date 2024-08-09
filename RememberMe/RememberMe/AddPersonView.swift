//
//  AddPersonView.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var selectedImage: Data
    
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
                        let person = Person(name: name, photo: selectedImage)
                        modelContext.insert(person)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationBarBackButtonHidden()
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
