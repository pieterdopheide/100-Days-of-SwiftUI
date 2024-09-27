//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Dopheide,Pieter on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                        //                            .background(colors[index % 7])
                            .background(Color(hue: min(proxy.frame(in: .global).minY / fullView.frame(in: .global).maxY, 1.0), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(proxy.frame(in: .global).minY / 200)
                            .opacity(max((fullView.size.height - proxy.frame(in: .global).minY) / (fullView.size.height / 3), 0.0))
                            .scaleEffect(max(proxy.frame(in: .global).minY / fullView.frame(in: .global).maxY + 0.5, 0.5))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
