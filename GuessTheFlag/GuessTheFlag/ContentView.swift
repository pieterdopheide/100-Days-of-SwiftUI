//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dopheide,Pieter on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var gameOver = false
    
    @State private var animationAmount = 0.0
    @State private var opacity = 1.0
    @State private var scale = 1.0
    @State private var flagTapped = 0
    
    let questionsToAsk = 8
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            flagTapped = number
                            withAnimation {
                                animationAmount += 360
                                opacity -= 0.75
                                scale = 0.5
                            }
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .opacity(flagTapped != number ? opacity : 1)
                        .rotation3DEffect(
                            .degrees(flagTapped == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0)
                        )
                        .scaleEffect(flagTapped != number ? scale : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Finished!", isPresented: $gameOver) {
            Button("Restart", action: restartGame)
        } message: {
            VStack {
                Text("""
Game Over!
You scored \(score) out of \(questionsToAsk).
""")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
        } else {
            if score > 0 {
                score -= 1
            }
            scoreTitle = "Wrong"
            if countries[number] == "UK" || countries[number] == "US" {
                scoreMessage = """
Wrong! That's the flag of the \(countries[number])
Your score is \(score)
"""
            } else {
                scoreMessage = """
Wrong! That's the flag of \(countries[number])
Your score is \(score)
"""
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        if questionsAsked == questionsToAsk - 1 {
            gameOver = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
        
        animationAmount = 0.0
        opacity = 1.0
        scale = 1.0
    }
    
    func restartGame() {
        questionsAsked = 0
        score = 0
        askQuestion()
    }
}

struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
