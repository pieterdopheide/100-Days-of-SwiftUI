//
//  ContentView.swift
//  Dice
//
//  Created by Dopheide,Pieter on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    var dice = ["4-sided", "6-sided", "8-sided", "10-sided", "12-sided", "20-sided", "100-sided"]
    @State private var selectedDie = "6-sided"
    
    @State private var amountOfDice = 1
    
    @State private var results: [Dice] = []
    @State private var total: Int?
    
    @State private var isShowingHistorySheet = false
    
    let gridItems = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        NavigationStack {
            VStack {
                if results.isEmpty {
                    ContentUnavailableView("Dice", systemImage: "dice", description: Text("Lets get rolling!"))
                } else {
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 30) {
                            ForEach(results) { result in
                                DiceView(value: result.value)
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 20)
                    }
                }
                
                VStack {
                    Text("Total:")
                    Text("\(total ?? 0)")
                }
            }
            
            HStack {
                Picker("Pick a die", selection: $selectedDie) {
                    ForEach(dice, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    Button(action: {
                        self.amountOfDice -= 1
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    .disabled(amountOfDice <= 1)
                    
                    TextField("Amount of dice to roll", value: $amountOfDice, format: .number)
                        .frame(width: 25)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        self.amountOfDice += 1
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    .disabled(amountOfDice >= 99)
                }
                .padding()
            }
            
            Button {
                rollXdX()
            } label: {
                Image(systemName: "dice.fill")
                Text("Roll Dice!")
            }
            .buttonStyle(.borderedProminent)
            .sensoryFeedback(trigger: results) { oldValue, newValue in
                let amount = Double(newValue.count / 10)
                return .impact(flexibility: .rigid, intensity: amount < 0.1 ? 0.1 : amount)
            }
            .sheet(isPresented: $isShowingHistorySheet) {
                HistoryView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingHistorySheet = true
                    } label: {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }
                }
            }
        }
    }
    
    func rollXdX() {
        let diceSides: Int = Int(selectedDie.split(separator: "-").first!)!
        
        var results = [Dice]()
        var total = 0
        for _ in 0..<amountOfDice {
            let value = Int.random(in: 1...diceSides)
            results.append(Dice(value: value))
            total += value
        }
        
        self.results = results
        self.total = total
        
        let rollLogRecord = RollLog(results: results.map { $0.value }, diceType: selectedDie)
        modelContext.insert(rollLogRecord)
    }
}

#Preview {
    ContentView()
}
