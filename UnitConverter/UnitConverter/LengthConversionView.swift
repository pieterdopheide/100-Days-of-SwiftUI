//
//  LengthConversionView.swift
//  UnitConverter
//
//  Created by Dopheide,Pieter on 24/04/2024.
//

import SwiftUI

struct LengthConversionView: View {
    @State private var inputUnit = 0.0
    @State private var inputUnitType = UnitLength.meters
    @State private var outputUnitType = UnitLength.feet
    @FocusState private var inputIsFocussed: Bool
    
    let units = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    var outputUnit: Double {
        Measurement(value: inputUnit, unit: inputUnitType).converted(to: outputUnitType).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Length to Convert") {
                    TextField("Amount", value: $inputUnit, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocussed)
                    Picker("Unit", selection: $inputUnitType) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                }
                Section("Convert to") {
                    Picker("Unit", selection: $outputUnitType) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                }
                Section("Result") {
                    Text(outputUnit, format: .number)
                }
            }
            .navigationTitle("Length")
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
    LengthConversionView()
}
