//
//  PhotoCredit.swift
//  SnowSeeker
//
//  Created by Dopheide,Pieter on 30/10/2024.
//

import SwiftUI

struct PhotoCredit: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func photoCredit(with text: String) -> some View {
        modifier(PhotoCredit(text: text))
    }
}
