//
//  ContentView.swift
//  FriendFace
//
//  Created by Dopheide,Pieter on 21/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink {
                    UserDetailView(user: user, users: users)
                } label: {
                    HStack {
                        Text(user.name)
                        
                        Spacer()
                        
                        Image(systemName: user.isActive ? "checkmark" : "xmark")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .task {
                if users.isEmpty {
                    await loadUsers()
                }
            }
        }
        .navigationTitle("FriendFace")
    }
    
    func loadUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
