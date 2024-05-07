//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Dopheide,Pieter on 06/05/2024.
//

import SwiftUI

struct AddActivityView: View {
    var activities: Activities
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $title)
                    
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = Activity(title: title, description: description)
                        activities.items.append(item)
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
