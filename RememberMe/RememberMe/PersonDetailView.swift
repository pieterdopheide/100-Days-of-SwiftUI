//
//  PersonDetailView.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

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
    PersonDetailView(person: Person(name: "John Doe", photo: UIImage(systemName: "person")!.pngData()!))
}
