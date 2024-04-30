//
//  QuestionView.swift
//  MultiplicationTables
//
//  Created by Dopheide,Pieter on 29/04/2024.
//

import SwiftUI

struct QuestionView: View {
    var multiplicationTable = 2
    var numberOfQuestions = 5
    
    @State private var questions = [Question]()
    @State private var questionNumber = 0
    
    @State private var answer = ""
    @State private var answerIsCorrect = false
    @State private var showResult = false
    
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var showOverview = false
    
    @State private var resultButtonSize = 0.0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Go!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.black)
                
                VStack(spacing: 15) {
                    Text("Multiplication Table")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text("\(multiplicationTable)")
                        .font(.largeTitle.weight(.semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                HStack(spacing: 15) {
                    Spacer()
                    
                    Text("Question \(questionNumber + 1)/\(numberOfQuestions)")
                    
                    Spacer()
                    
                    VStack {
                        Text("Correct: \(correctAnswers)")
                        
                        Text("Wrong: \(wrongAnswers)")
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                VStack {
                    Text("What is \(!questions.isEmpty ? questions[questionNumber].question : "")?")
                    
                    TextField("Answer", text: $answer)
                        .disabled(true)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                VStack {
                    HStack {
                        ForEach(7..<10) { number in
                            Button("\(number)") {
                                answer += "\(number)"
                            }
                            .font(.system(size: 20))
                            .padding(20)
                            .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                            .clipShape(.circle)
                        }
                    }
                    
                    HStack {
                        ForEach(4..<7) { number in
                            Button("\(number)") {
                                answer += "\(number)"
                            }
                            .font(.system(size: 20))
                            .padding(20)
                            .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                            .clipShape(.circle)
                        }
                    }
                    
                    HStack {
                        ForEach(1..<4) { number in
                            Button("\(number)") {
                                answer += "\(number)"
                            }
                            .font(.system(size: 20))
                            .padding(20)
                            .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                            .clipShape(.circle)
                        }
                    }
                    
                    HStack {
                        Button("0") {
                            answer += "0"
                        }
                        .font(.system(size: 20))
                        .padding(20)
                        .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                        .clipShape(.circle)
                        
                        Button("Del") {
                            answer.remove(at: answer.index(before: answer.endIndex))
                        }
                        .font(.system(size: 15))
                        .padding(20)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                    }
                    
                    Button("Submit") {
                        answerIsCorrect = checkAnswer()
                        
                        if answerIsCorrect {
                            correctAnswers += 1
                        } else {
                            wrongAnswers += 1
                        }
                        
                        withAnimation {
                            showResult = true
                            resultButtonSize = 1.0
                        }
                        
                        if questionNumber < numberOfQuestions - 1 {
                            questionNumber += 1
                        } else {
                            showResult = false
                            showOverview = true
                        }
                        
                        answer = ""
                    }
                    .padding(10)
                    .background(.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14.0, style: .continuous))
                }
                
                Spacer()
                
                Image(systemName: answerIsCorrect ? "checkmark.circle" : "xmark.circle")
                .foregroundStyle(.white)
                .background(answerIsCorrect ? .green : .red)
                .clipShape(.circle)
                .scaleEffect(resultButtonSize)
                .font(.system(size: 50))
                .animation(.easeIn(duration: 0.2), value: resultButtonSize)
            }
            .onAppear {
                generateQuestions()
            }
            .padding()
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        
        for _ in 1...numberOfQuestions {
            let multiplication = Int.random(in: 1...12)
            questions.append(Question(question: "\(multiplicationTable) x \(multiplication)", answer: multiplicationTable * multiplication))
        }
    }
    
    func checkAnswer() -> Bool {
        questions[questionNumber].answer == Int(answer) ?? 0
    }
}

struct Question {
    let question: String
    let answer: Int
}

#Preview {
    QuestionView()
}
