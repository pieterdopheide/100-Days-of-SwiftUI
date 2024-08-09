//
//  ContentView.swift
//  RememberMe
//
//  Created by Dopheide,Pieter on 09/08/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: [
        SortDescriptor(\Person.name)
    ]) var people: [Person]
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Data?
    @State private var showingAddPersonSheet = false
    
    var body: some View {
        NavigationStack {
            List(people) { person in
                NavigationLink {
                    PersonDetailView(person: person)
                } label: {
                    HStack {
                        person.photoImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("\(person.name)")
                    }
                }
            }
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                        Image(systemName: "plus")
                            .padding()
                            .font(.largeTitle)
                            .background(.blue)
                            .foregroundColor(.white)
                            .clipShape(.circle)
                            .padding(.trailing)
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    selectedImage = try await pickerItem?.loadTransferable(type: Data.self)
                }
            }
            .onChange(of: selectedImage) {
                showingAddPersonSheet.toggle()
            }
            .sheet(isPresented: $showingAddPersonSheet) {
                if let image = selectedImage {
                    AddPersonView(selectedImage: image)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
