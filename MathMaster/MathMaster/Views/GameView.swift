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
     
    /// GameLength from Settings
    @AppStorage("gameDuration") private var gameDuration = 60
    
    /// TImer States
    @State var remeiningTime: Int = 0
    @State var timerJob: Timer?
    
    /// Game States
    @State var math: Math?
    @State var rightAnswer: Int = 0
    @State var wrongAnswer: Int = 0
    @State var points = 0
    
    /// Alert States
    @State var showingResultAlert = false
    
    /// Switch RemainingTime Color By Left Time
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
                        Text("\(math.displayText) =")
                        
                        Text("?")
                            .padding(10)
                            .background(.gray.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    Spacer()
                }
                .font(.largeTitle)
                .fontWeight(.bold)
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
            
            showingResultAlert = true
             
            // TODO: FIND #Ranking in POINT DB
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
        pauseTimer()
        showingResultAlert = false // Alert schließen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Logik zur Navigation implementieren
            // Beispiel:
            // presentationMode.wrappedValue.dismiss()
        }
    }
}
