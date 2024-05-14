//
//  ContentView.swift
//  iExpense
//
//  Created by Dopheide,Pieter on 01/05/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name)
    ]
    
    @State private var filterOptions = ["All", "Business", "Personal"]
    @State var filter = "All"
    
    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: sortOrder, filter: $filter)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                        }
                    }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $filter) {
                            ForEach(filterOptions, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
        }
    }
}

struct ExpenseStyle: ViewModifier {
    let expenseItem: ExpenseItem
    
    func body(content: Content) -> some View {
        if expenseItem.amount <= 10 {
            content.foregroundColor(.green)
        } else if expenseItem.amount <= 100 {
            content.foregroundColor(.orange)
        } else {
            content
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

extension View {
    func expenseStyle(for expenseItem: ExpenseItem) -> some View {
        modifier(ExpenseStyle(expenseItem: expenseItem))
    }
}

#Preview {
    ContentView()
}
