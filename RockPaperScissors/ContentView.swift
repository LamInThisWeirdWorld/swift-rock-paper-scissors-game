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
    
    @State private var point = 0
    @State private var routeNum = 0
    
    @State private var showingScore = false
    @State private var gameStarted = false
    @State private var gameEnded = false
    
    let choices = ["👊Rock👊", "🖐️Paper🖐️", "✌️Scissors✌️"]
    let beats : [String: String] = [
        "👊Rock👊": "✌️Scissors✌️",
        "🖐️Paper🖐️": "👊Rock👊",
        "✌️Scissors✌️": "🖐️Paper🖐️"
    ]
    
    var body: some View {
        VStack {
            if !gameStarted {
                Button {
                    generateRoute()
                    gameStarted = true
                } label: {
                    Text("Start")
                        .font(.largeTitle)
                }
            }
            
//            HStack(spacing: 20) {
//                Text(randomPick)
//                Text(randomResult)
//            }
//            .font(.title)
            
//            Text(correctChoice)
            
            
            VStack(spacing: 20) {
                if gameStarted {
                    Text("Route \(routeNum)")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Text(randomPick)
                            .padding(.trailing, 25)
                        Text(randomResult)
                            .padding(.leading, 25)
                            .foregroundColor(randomResult == "Win" ? .green : .red)
                    }
                    .font(.title.bold())
                    Spacer()
                    ForEach(choices, id: \.self) { choice in
                        Button {
                            checkChoice(choose: choice)
                        } label: {
                            Text(choice)
                                .font(.system(size: 40))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Text("\(point) points")
                        .foregroundStyle(.black)
                        .font(.title.bold())
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("continue", action: generateRoute)
        } message: {
            Text("Your choice is \(scoreTitle)\nYou have \(point) point")
        }
        .alert("Game End!", isPresented: $gameEnded) {
            Button("NEW GAME", action: newGame)
        } message: {
            Text("Your total point is \(point)")
        }
    }
    
    func generateRoute() {
        if routeNum < 10 {
            randomPick = choices.randomElement()!
            randomResult = Bool.random() ? "Win" : "Lose"
            correctChoice = correctAnswer(state: randomResult, opponent: randomPick)
            routeNum += 1
        } else {
            gameEnded = true
        }
    }
    
    func newGame() {
        gameStarted = false
        gameEnded = false
        point = 0
        routeNum = 1
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
            point += 1
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
