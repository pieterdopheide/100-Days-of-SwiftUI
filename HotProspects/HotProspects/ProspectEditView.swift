//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Dopheide,Pieter on 12/08/2024.
//

import SwiftUI

struct ProspectEditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $prospect.name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $prospect.emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
            }
            .navigationTitle("Edit")
        }
    }
}

#Preview {
    ProspectEditView(prospect: Prospect(name: "Pieter Dopheide", emailAddress: "pjmdopheide@gmail.com", isContacted: false))
}
