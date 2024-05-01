//
//  ContentView.swift
//  iExpense
//
//  Created by Dopheide,Pieter on 01/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(expenses.items.filter({ $0.type == "Business" })) { item in
                        HStack {
                            Image(systemName: item.type == "Personal" ? "person" : "suitcase")
                            
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                .expenseStyle(for: item)
                        }
                    }
                    .onDelete(perform: removeBusinessExpense)
                }
                
                Section("Personal") {
                    ForEach(expenses.items.filter({ $0.type == "Personal" })) { item in
                        HStack {
                            Image(systemName: item.type == "Personal" ? "person" : "suitcase")
                            
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                .expenseStyle(for: item)
                        }
                    }
                    .onDelete(perform: removePersonalExpense)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeBusinessExpense(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == expenses.items.filter({ $0.type == "Business" })[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removePersonalExpense(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == expenses.items.filter({ $0.type == "Personal" })[offset].id }) {
                expenses.items.remove(at: index)
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
