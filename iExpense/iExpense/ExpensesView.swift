//
//  ExpensesView.swift
//  iExpense
//
//  Created by Dopheide,Pieter on 14/05/2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @Binding var filter: String
    
    var body: some View {
        List {
            switch filter {
            case "Business":
                Section("Business") {
                    ForEach(expenses.filter({ $0.type == "Business" })) { item in
                        ExpenseView(item: item)
                    }
                    .onDelete(perform: removeBusinessExpense)
                }
            case "Personal":
                Section("Personal") {
                    ForEach(expenses.filter({ $0.type == "Personal" })) { item in
                        ExpenseView(item: item)
                    }
                    .onDelete(perform: removePersonalExpense)
                }
            default:
                Section("Business") {
                    ForEach(expenses.filter({ $0.type == "Business" })) { item in
                        ExpenseView(item: item)
                    }
                    .onDelete(perform: removeBusinessExpense)
                }
                
                Section("Personal") {
                    ForEach(expenses.filter({ $0.type == "Personal" })) { item in
                        ExpenseView(item: item)
                    }
                    .onDelete(perform: removePersonalExpense)
                }
            }
        }
    }
    
    func removeBusinessExpense(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.firstIndex(where: { $0.id == expenses.filter({ $0.type == "Business" })[offset].id }) {
                modelContext.delete(expenses[index])
            }
        }
    }
    
    func removePersonalExpense(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.firstIndex(where: { $0.id == expenses.filter({ $0.type == "Personal" })[offset].id }) {
                modelContext.delete(expenses[index])
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], filter: Binding<String>) {
        _expenses = Query(sort: sortOrder)
        _filter = filter
    }
}

#Preview {
    ExpensesView(sortOrder: [SortDescriptor(\ExpenseItem.name)], filter: .constant("All"))
}
