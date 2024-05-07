//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Dopheide,Pieter on 06/05/2024.
//

import SwiftUI

struct ActivityView: View {
    var activities: Activities
    var activity: Activity
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Description") {
                    Text(activity.description)
                }
                
                Section("Times completed") {
                    HStack {
                        Text("\(activity.timesCompleted)")
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                incrementCount()
                            } label: {
                                Image(systemName: "plus")
                            }
                            .buttonStyle(.borderless)
                            
                            Button {
                                decrementCount()
                            } label: {
                                Image(systemName: "minus")
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .navigationTitle(activity.title)
        }
    }
    
    func incrementCount() {
        var activityCopy = activity
        activityCopy.timesCompleted += 1
        
        let index = activities.items.firstIndex(of: activity)
        if let index {
            activities.items[index] = activityCopy
        }
    }
    
    func decrementCount() {
        if activity.timesCompleted > 0 {
            var activityCopy = activity
            activityCopy.timesCompleted -= 1
            
            let index = activities.items.firstIndex(of: activity)
            if let index {
                activities.items[index] = activityCopy
            }
        }
    }
}

#Preview {
    let activity = Activity(title: "Running", description: "I want to get fitter.")
    let activities = Activities()
    activities.items.append(activity)
    
    return ActivityView(activities: activities, activity: activity)
}
