//
//  ProspectListingView.swift
//  HotProspects
//
//  Created by Dopheide,Pieter on 12/08/2024.
//

import SwiftData
import SwiftUI

struct ProspectsListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    
    let filter: FilterType
    @Binding var selectedProspects: Set<Prospect>
    
    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                ProspectEditView(prospect: prospect)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    if filter == .none {
                        Image(systemName: prospect.isContacted ? "person.crop.circle.badge.xmark" : "person.crop.circle.fill.badge.checkmark")
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
        }
    }
    
    init(filter: FilterType, selectedProspects: Binding<Set<Prospect>>, sortOrder: [SortDescriptor<Prospect>]) {
        self.filter = filter
        self._selectedProspects = selectedProspects
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        } else {
            _prospects = Query(sort: sortOrder)
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
#if targetEnvironment(simulator)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
#else
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
#endif
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var selectedProspects = Set<Prospect>()
        
        var body: some View {
            ProspectsListingView(filter: .none, selectedProspects: $selectedProspects, sortOrder: [SortDescriptor(\Prospect.name)])
                .modelContainer(for: Prospect.self)
        }
    }
    
    return Preview()
}
