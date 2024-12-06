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
    @Environment(\.dismiss) var dismiss
    
    var user: User?
    
    /// GameLength from Settings
    @AppStorage("gameDuration") private var gameDuration = 60
    
    /// TImer States
    @State var remeiningTime: Int = 0
    @State var timerJob: Timer?
    @State var saved = false
    
    /// Game States
    @State var math: Math?
    @State var rightAnswer: Int = 0
    @State var wrongAnswer: Int = 0
    @State var points = 0
    
    @State var answer: Int? = nil
    
    /// Alert States
    @State var showingResultAlert = false
    
    /// Switch RemainingTime Color By Left Time
    var timerColor: Color {
        remeiningTime < 10 ? .red : timerJob == nil ? .gray : .green
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .leading){
                /// Hintergrund
                Image("backgroundGame")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
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
                  
                    .padding(32)
                    
                    
                    VStack {
                      
                        
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
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                    }
                    .padding(32)
                    
                    NumberPadView() { result in
                        answer = result
                        checkAnswer(result: result)
                        math = MathHelper.generateRandomMath()
                    }
                  
                }
            }
            if showingResultAlert {
                AlertView(points: points, home: navigateHome, newGame: restartGame)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer()
            math = MathHelper.generateRandomMath()
        }
        .onDisappear{
            pauseTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                dismiss()
            }
        }
        .overlay(
            Group {
                if showingResultAlert {
                    AlertView(points: points, home: {
                        showingResultAlert = false
                        navigateHome()
                    }, newGame: {
                        showingResultAlert = false
                        restartGame()
                    })
                    .background(Color.black.opacity(0.5).ignoresSafeArea())
                }
            }
        )
   
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
                pauseTimer()
                gameFinished()
            }
        }
    }
    
    private func checkAnswer(result: Int) {
        if math?.result == result {
            rightAnswer += 1
            points += 10
        } else {
            wrongAnswer += 1
            points -= 10
        }
    }
    
    private func gameFinished() {
        guard saved == false else {return}
        if let user = user {
            let gameResult = Statistic(gameType: "", date: Date(), points: points, rightAnswers: rightAnswer, wrongAnswers: wrongAnswer)
            
            user.games.append(gameResult)
            
            showingResultAlert = true
            saved = true
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
        saved = false
    }
    
    private func navigateHome() {
        pauseTimer()
        showingResultAlert = false // Alert schließen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            dismiss()
        }
    }
}
