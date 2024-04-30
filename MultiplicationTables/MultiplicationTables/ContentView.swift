//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Dopheide,Pieter on 29/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var numberOfQuestionsOptions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Multiplication table") {
                    Picker("Multiplication table", selection: $multiplicationTable) {
                        ForEach(2..<11, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                }
                
                Section("Number of questions") {
                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionsOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section() {
                    NavigationLink {
                        QuestionView(multiplicationTable: multiplicationTable, numberOfQuestions: numberOfQuestions)
                    } label: {
                        Button("Start") { }
                    }
                }
            }
            .navigationTitle("Tables")
        }
    }
}

#Preview {
    ContentView()
}
