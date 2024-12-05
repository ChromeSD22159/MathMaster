//
//  Stats.swift
//  MathMaster
//
//  Created by Christoph Schwalm on 02.12.24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    
    @Environment(\.modelContext) var context
    @Query var user: [User]
    
    var body: some View {
        VStack{
            Text("User Stats")
                .font(.title2)
            ForEach(user) { user in
                VStack {
                    Text(user.name)
                    Text("Alter: \(user.age)")
                    Divider()
                    
                    ForEach(user.games) { game in
                        HStack{
                            Text(game.gameType)
                            Text(game.date.formatted(date: .numeric, time: .omitted))
                            Text("Punkte: \(game.points)")
                            Text("Richtige: \(game.rightAnswers)")
                            Text("Falsch: \(game.wrongAnswers)")
                        }
                        .font(.system(size: 12))
                        
                    }
                    
                    Divider()
                    
                    
                }
            }
        }
    }
}


#Preview {
    StatsView()
        .modelContainer(previewContainer)
}
