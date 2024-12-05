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
    var userID: String
    
    init(userID: String) {
        self.userID = userID
        
        let predicate = #Predicate<User> { user in
            user.userID == userID
        }
        _user = Query(filter: predicate)
    }
    
    
    var body: some View {
        VStack{
            Text("Stats für \(user.first?.name ?? "")")
                .font(.title2)
            ForEach(user) { user in
                VStack {
                    Text(user.name)
                    Text("Alter: \(user.age)")
                    Divider()
                    
                    List{
                        ForEach(user.games.sorted { $0.date > $1.date}) { game in
                            HStack{
                                Text(game.gameType)
                                Text(game.date.formatted(date: .numeric, time: .omitted))
                                Text("Punkte: \(game.points)")
                                Text("Richtige: \(game.rightAnswers)")
                                Text("Falsch: \(game.wrongAnswers)")
                            }
                            .font(.system(size: 12))
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive, action: {
                                    deleteStats(game: game)
                                }){
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                        
                    }
                    
                }
                
                Divider()
                
                
            }
        }
        
    }
    
    
    func deleteStats(game: Statistic ) {
        context.delete(game)
    }
    
}




#Preview {
    StatsView(userID: maria.userID)
        .modelContainer(previewContainer)
}
