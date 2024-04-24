//
//  TemperatureConversionView.swift
//  UnitConverter
//
//  Created by Dopheide,Pieter on 24/04/2024.
//

import SwiftUI

struct TemperatureConversionView: View {
    @State private var inputUnit = 0.0
    @State private var inputUnitType = UnitTemperature.celsius
    @State private var outputUnitType = UnitTemperature.fahrenheit
    @FocusState private var inputIsFocussed: Bool
    
    let units = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    var outputUnit: Double {
        Measurement(value: inputUnit, unit: inputUnitType).converted(to: outputUnitType).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature to Convert") {
                    TextField("Degrees", value: $inputUnit, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocussed)
                    Picker("Unit", selection: $inputUnitType) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Convert to") {
                    Picker("Unit", selection: $outputUnitType) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Result") {
                    Text(outputUnit, format: .number)
                }
            }
            .navigationTitle("Temperature")
            .toolbar {
                if inputIsFocussed {
                    Button("Done") {
                        inputIsFocussed = false
                    }
                }
            }
        }
    }
}

#Preview {
    TemperatureConversionView()
}
