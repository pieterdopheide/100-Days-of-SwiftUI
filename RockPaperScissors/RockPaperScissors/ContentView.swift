//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dopheide,Pieter on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var appsMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var roundsPlayed = 0
    @State private var gameOver = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    let maxRounds = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
//                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.1, green: 0.58, blue: 0.68), location: 0.3),
//                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                .init(color: Color(red: 0.63, green: 0.8, blue: 0.88), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack() {
                Spacer()
                
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Goal")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text("\(shouldWin ? "Win" : "Lose")")
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    MoveImage(moveIndex: appsMove)
                        .font(.system(size: 160))
                        .padding(50)
                        .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                        .clipShape(.circle)
                        .shadow(radius: 5)
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                moveChosen(number)
                            } label: {
                                MoveImage(moveIndex: number)
                                    .font(.system(size: 50))
                                    .padding(20)
                                    .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                                    .clipShape(.circle)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    func moveChosen(_ move: Int) {
        if shouldWin {
            if playersMoveWins(playersMove: move) {
                score += 1
            }
        } else {
            if !playersMoveWins(playersMove: move) {
                score += 1
            }
        }
        roundsPlayed += 1
        appsMove = Int.random(in: 0...2)
        shouldWin.toggle()
        if roundsPlayed == maxRounds {
            gameOver = true
        }
    }
    
    func playersMoveWins(playersMove: Int) -> Bool {
        appsMove + 1 == moves.count ? playersMove == 0 : playersMove > appsMove
    }
    
    func reset() {
        appsMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        score = 0
        roundsPlayed = 0
    }
}

struct MoveImage: View {
    var moveIndex = 0
    
    var body: some View {
        if moveIndex == 0 {
            Text("✊")
        } else if moveIndex == 1 {
            Text("✋")
        } else {
            Text("✌️")
        }
    }
}

#Preview {
    ContentView()
}
