//
//  RollLogSheetView.swift
//  Dice
//
//  Created by Dopheide,Pieter on 01/10/2024.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \RollLog.dateRolled, order: .reverse) var rolls: [RollLog]
    
    @State private var isPresentingAlert = false
    
    var body: some View {
        NavigationStack {
            Group {
                if rolls.isEmpty {
                    ContentUnavailableView("History", systemImage: "dice", description: Text("No dice have been rolled yet. Start rolling some dice!"))
                } else {
                    Form {
                        List {
                            ForEach(rolls) { roll in
                                VStack {
                                    HStack {
                                        Text("\(roll.diceRolled)d\(roll.diceType.split(separator: "-").first!) total: \(roll.total) ")
                                        
                                        Spacer()
                                        
                                        Text(roll.dateRolled, style: isDateToday(date: roll.dateRolled) ? .time : .date)
                                            .font(.caption)
                                    }
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(roll.results, id: \.self) { result in
                                                DiceView(value: result)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                        
                        Section {
                            Button(role: .destructive) {
                                isPresentingAlert = true
                            } label: {
                                Text("Clear History")
                            }
                            .alert(isPresented: $isPresentingAlert) {
                                Alert(
                                    title: Text("Delete History"),
                                    message: Text("Are you sure you want to delete the history? This cannot be undone!"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        do {
                                            try modelContext.delete(model: RollLog.self)
                                        } catch {
                                            print("Failed to clear all history data.")
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func isDateToday(date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: date)
        
        return calendar.isDate(today, inSameDayAs: otherDate)
    }
}

#Preview("No History") {
    HistoryView()
}

#Preview("With History") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: RollLog.self, configurations: config)
    
    let rollLog1 = RollLog(results: [5, 1, 6, 5, 1, 2, 4], diceType: "6-sided")
    container.mainContext.insert(rollLog1)
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let exampleDate = formatter.date(from: "2024-09-27 16:23")!
    let rollLog2 = RollLog(results: [2, 5, 7, 2, 12, 11], diceType: "10-sided", dateRolled: exampleDate)
    container.mainContext.insert(rollLog2)
    
    return HistoryView()
        .modelContainer(container)
}
