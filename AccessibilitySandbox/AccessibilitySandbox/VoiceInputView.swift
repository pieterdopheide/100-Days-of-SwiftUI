//
//  VoiceInputView.swift
//  AccessibilitySandbox
//
//  Created by Dopheide,Pieter on 27/06/2024.
//

import SwiftUI

struct VoiceInputView: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    VoiceInputView()
}
