//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nguyen Ngoc Thanh Lam on 7/7/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var randomPick = ""
    @State private var randomResult = ""
    @State private var result = ""
    @State private var correctChoice = ""
    @State private var scoreTitle = ""
    
    @State private var showingScore = false
    @State private var gameStarted = false
    
    let choices = ["Rock", "Paper", "Scissors"]
    let beats : [String: String] = [
        "Rock": "Scissors",
        "Paper": "Rock",
        "Scissors": "Paper"
    ]
    
    var body: some View {
        VStack {
            if !gameStarted {
                Button {
                    generateRoute()
                    gameStarted = true
                } label: {
                    Text("Start")
                }
            }
            
            HStack(spacing: 20) {
                Text(randomPick)
                Text(randomResult)
            }
            
//            Text(correctChoice)
            
            
            VStack(spacing: 20) {
                ForEach(choices, id: \.self) { choice in
                    Button {
                        checkChoice(choose: choice)
                    } label: {
                        Text(choice)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("continue", action: generateRoute)
        } message: {
            Text("your choice is" + scoreTitle)
        }
    }
    
    func generateRoute() {
        randomPick = choices.randomElement()!
        randomResult = Bool.random() ? "Win" : "Lose"
        correctChoice = correctAnswer(state: randomResult, opponent: randomPick)
    }
    
    func correctAnswer(state: String, opponent: String) -> String {
        if state == "Win" {
            for (key, value) in beats {
                if value == opponent {
                    return key
                }
            }
            // if we need to lose, choose the opponent that beats us
        } else {
            return beats[opponent]!
        }
        return ""
    }
    
    
    func checkChoice(choose choice: String) {
        if choice == correctChoice {
            scoreTitle = "Correct!"
        } else {
            scoreTitle = "Wrong :("
        }
        showingScore = true
    }
}

#Preview {
    ContentView()
}


// first brute force attempt for the logic of win and lose
//func correctAnswer() -> String {
//    if randomResult == "Win" {
//        if randomIndex == 2 {
//            correctChoice = choice[0]
//        } else {
//            correctChoice = choice[randomIndex + 1]
//        }
//    } else {
//        if randomIndex == 0 {
//            correctChoice = choice[2]
//        } else {
//            correctChoice = choice[randomIndex - 1]
//        }
//    }
//    return correctChoice
//}


// first attempt to check if player choose the right ans
//Button {
//    checkChoice(choose: "Rock")
//} label: {
//    Text("Rock")
//}
//Button {
//    checkChoice(choose: "Paper")
//} label: {
//    Text("Paper")
//}
//Button {
//    checkChoice(choose: "Scissors")
//} label: {
//    Text("Scissors")
//}
