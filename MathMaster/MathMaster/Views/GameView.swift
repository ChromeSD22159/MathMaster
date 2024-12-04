//
//  Game.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//
import SwiftUI
import SwiftData

struct GameView: View {
    @Environment(\.modelContext) var modelContext
      
    var user: User?
    
    @State var math: Math?
    
    @AppStorage("gameDuration") private var gameDuration = 60
    
    @State var remeiningTime: Int = 0
    @State var timerJob: Timer?
    
    @State var rightAnswer: Int = 0
    @State var wrongAnswer: Int = 0
    @State var points = 0
    
    @State var showingResultAlert = false
    
    var timerColor: Color {
        remeiningTime < 10 ? .red : timerJob == nil ? .gray : .green
    }
    
    var body: some View {
        VStack {
            HStack {
                Label("\(remeiningTime)", systemImage: "timer")
                    .foregroundStyle(timerColor)
                    .onTapGesture {
                        if timerJob == nil {
                            restartTimer()
                        } else {
                            pauseTimer()
                        }
                    }
                
                Spacer()
                
                HStack {
                    Label("\(rightAnswer)", systemImage: "checkmark.seal.fill").foregroundStyle(.green)
                    Label("\(wrongAnswer)", systemImage: "xmark.seal.fill").foregroundStyle(.red)
                }
            }
            .cardStyle()
            
            VStack {
                HStack {
                    Text("Frage:")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    if let math = math {
                        Text("\(math.displayText) = ?")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
            }
            .cardStyle()
            
            NumberPadView() { result in
                checkAnswer(result: result)
                math = MathHelper.generateRandomMath()
            }
        }
        .onAppear {
            startTimer()
            math = MathHelper.generateRandomMath()
        }
        .alert(isPresented: $showingResultAlert) {
            Alert(
                title: Text("Spiel zuende!"),
                message: Text("Dein Punktestand: \(points)"),
                primaryButton: .default(
                    Text("Nocheinmal Spielen"),
                    action: restartGame
                ),
                secondaryButton: .destructive(
                    Text("Home"),
                    action: navigateHome
                )
            )
        }
    }
    
    private func startTimer() {
        remeiningTime = gameDuration
        timerJob = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remeiningTime > 0 {
                remeiningTime -= 1
            } else {
                gameFinished()
            }
        }
    }
    
    private func pauseTimer() {
        timerJob?.invalidate()
        timerJob = nil
    }
    
    private func restartTimer() {
        timerJob = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remeiningTime > 0 {
                remeiningTime -= 1
            } else {
                gameFinished()
            }
        }
    }
    
    private func checkAnswer(result: Int) {
        if math?.result == result {
            print("Richtig!")
            rightAnswer += 1
            points += 10
        } else {
            print("Falsch!")
            wrongAnswer += 1
            points -= 10
        }
    }
    
    private func gameFinished() {
        if let user = user {
            let gameResult = Statistic(name: user.name, gameType: "", date: Date(), points: points, rightAnswers: rightAnswer, wrongAnswers: wrongAnswer)
            
            modelContext.insert(gameResult)
            
            // TODO: FIND #Ranking in POINT DB
            
            showingResultAlert = true
        }
    }
    
    private func restartGame() {
        showingResultAlert = false
        rightAnswer = 0
        wrongAnswer = 0
        points = 0
        startTimer()
        math = MathHelper.generateRandomMath()
    }
    
    private func navigateHome() {
        showingResultAlert = false
        
        // TODO: NAVIGATE TO HOME
    }
} 
