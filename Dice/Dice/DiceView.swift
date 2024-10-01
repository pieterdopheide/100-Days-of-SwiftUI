//
//  DiceView.swift
//  Dice
//
//  Created by Dopheide,Pieter on 01/10/2024.
//

import SwiftUI

struct DiceView: View {
    let value: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            
            Text("\(value)")
        }
    }
}

#Preview {
    DiceView(value: 6)
}
