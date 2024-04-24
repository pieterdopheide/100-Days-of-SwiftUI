//
//  ContentView.swift
//  UnitConverter
//
//  Created by Dopheide,Pieter on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink {
                    LengthConversionView()
                } label: {
                    Label("Length conversion", systemImage: "ruler")
                }
                NavigationLink {
                    TemperatureConversionView()
                } label: {
                    Label("Temperature conversion", systemImage: "thermometer.medium")
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
