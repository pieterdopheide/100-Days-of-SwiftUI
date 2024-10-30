//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Dopheide,Pieter on 04/10/2024.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            sortResorts(resorts)
        } else {
            sortResorts(resorts.filter { $0.name.localizedStandardContains(searchText) })
        }
    }
    
    var resortOrders = ["Default", "Alphabetical", "Country"]
    @State private var selectedResortOrder = "Default"
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Order to display resorts", selection: $selectedResortOrder) {
                            ForEach(resortOrders, id: \.self) {
                                Text($0)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
    
    func sortResorts(_ resorts: [Resort]) -> [Resort] {
        switch selectedResortOrder {
        case "Alphabetical":
            return resorts.sorted { $0.name < $1.name }
        case "Country":
            return resorts.sorted { $0.country < $1.country }
        default:
            return resorts
        }
    }
}

#Preview {
    ContentView()
}
