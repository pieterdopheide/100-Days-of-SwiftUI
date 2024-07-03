//
//  ExpenseView.swift
//  iExpense
//
//  Created by Dopheide,Pieter on 14/05/2024.
//

import SwiftUI

struct ExpenseView: View {
    var item: ExpenseItem
    
    var body: some View {
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
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(item.name) costing \(item.amount)")
        .accessibilityHint(item.type)
    }
}

#Preview {
    ExpenseView(item: ExpenseItem(name: "Laptop", type: "Business", amount: 2500.0))
}
