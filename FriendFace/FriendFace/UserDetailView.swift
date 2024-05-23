//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Dopheide,Pieter on 22/05/2024.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let users: [User]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text(user.isActive ? "Active" : "Inactive")
                        Image(systemName: user.isActive ? "checkmark" : "xmark")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                }
                
                Section("About") {
                    Text(user.about)
                }
                
                Section("Tags") {
                    List(user.tags, id: \.self) {
                        Text($0)
                    }
                }
                
                Section("Friends") {
                    if !user.friends.isEmpty {
                        List(user.friends) { friend in
                            NavigationLink {
                                UserDetailView(user: users.first(where: { $0.id == friend.id }) ?? anonymousUser(), users: users)
                            } label: {
                                Text(friend.name)
                            }
                        }
                    } else {
                        Text("None")
                    }
                }
            }
            .navigationTitle(user.name)
        }
    }
    
    func anonymousUser() -> User {
        User(id: UUID(),
             isActive: false,
             name: "Anonymous",
             age: 0,
             company: "",
             email: "",
             address: "",
             about: "",
             registered: .now,
             tags: [],
             friends: []
        )
    }
}

#Preview {
    UserDetailView(
        user: User(
            id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!,
            isActive: false,
            name: "Alford Rodriguez",
            age: 21,
            company: "Imkan",
            email: "alfordrodriguez@imkan.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            registered: Date.now,
            tags: [
                "cillum",
                "consequat",
                "deserunt",
                "nostrud",
                "eiusmod",
                "minim",
                "tempor"
            ],
            friends: [
                Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel"),
                Friend(id: UUID(uuidString: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6")!, name: "Jewel Sexton")
            ]
        ),
        users: [
            User(
                id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!,
                isActive: true,
                name: "Hawkins Patel",
                age: 27,
                company: "Mazuda",
                email: "hawkinspatel@mazuda.com",
                address: "256 Union Avenue, Baker, New Mexico, 518",
                about: "Consectetur mollit fugiat dolor ea esse reprehenderit enim laboris laboris. Eiusmod consectetur quis cillum tempor veniam deserunt do. Qui ea amet esse qui mollit non non dolor sint consequat ullamco cillum. Sunt aute elit qui elit.",
                registered: Date.now,
                tags: [
                    "minim",
                    "commodo",
                    "do",
                    "aliquip",
                    "elit",
                    "incididunt",
                    "pariatur"
                 ],
                friends: []
            ),
            User(id: UUID(uuidString: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6")!,
                isActive: true,
                name: "Jewel Sexton",
                age: 31,
                company: "Exoteric",
                email: "jewelsexton@exoteric.com",
                address: "799 Chestnut Street, Bluetown, Kansas, 9874",
                about: "Quis deserunt labore nostrud pariatur culpa velit ea adipisicing. Sit occaecat sint cillum irure eiusmod eu nostrud ex commodo proident incididunt aliqua. Sit fugiat consectetur occaecat ipsum pariatur.",
                registered: .now,
                tags: [
                    "et",
                    "esse",
                    "enim",
                    "qui",
                    "sunt",
                    "ullamco",
                    "irure"
                ],
                friends: []
            )
        ]
    )
}
