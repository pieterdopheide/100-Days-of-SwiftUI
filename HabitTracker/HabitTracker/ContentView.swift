//
//  ContentView.swift
//  HabitTracker
//
//  Created by Dopheide,Pieter on 06/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink {
                        ActivityView(activities: activities, activity: activity)
                    } label: {
                        HStack {
                            Image(systemName: "person")
                            
                            Text(activity.title)
                            
                            Spacer()
                            
                            Text("\(activity.timesCompleted)")
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .overlay {
                if activities.items.isEmpty {
                    HStack {
                        Image(systemName: "person")
                        
                        Text("No activities found")
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                }
            }
            .toolbar {
                Button("Add activity", systemImage: "plus") {
                    showingAddActivity = true
                }
            }
            .sheet(isPresented: $showingAddActivity, content: {
                AddActivityView(activities: activities)
            })
            .navigationTitle("Activities")
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
