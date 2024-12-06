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
        ZStack{
            // MARK: - Background
            VStack {
                Image("headerGreen")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 167)
                    .ignoresSafeArea(edges: .top)
                
                Spacer()
            }
            
            VStack{
                Button {
                    user.forEach { user in
                        user.games.forEach { game in
                            context.delete(game)
                        }
                    }
                    
                    
                } label: {
                    Spacer()
                    Image(systemName: "trash")
                        .tint(.red)
                        .padding(.trailing, 24)
                }
                
                
                Text("Statistik für \(user.first?.name ?? "")")
                    .font(.title2)
                    .bold()
                
                ForEach(user) { user in
                    VStack {
                      
                        
                        List{
                            ForEach(user.games.sorted { $0.date > $1.date}) { game in
                                VStack{
                                    HStack{
                                        Text(game.gameType)
                                        Spacer()
                                        Text(game.date.formatted(date: .numeric, time: .omitted))
                                        
                                    }
                                    HStack{
                                        Image(systemName: "checkmark.seal")
                                            .foregroundStyle(.green)
                                        Text("\(game.rightAnswers)")
                                        Spacer()
                                        Image(systemName: "xmark.seal")
                                            .foregroundStyle(.red)
                                        Text("\(game.wrongAnswers)")
                                        Spacer()
                                        Text("Punkte: \(game.points)")
                                    }
                                }
                                .font(.system(size: 16))
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
    }
    
    
    func deleteStats(game: Statistic ) {
        context.delete(game)
    }
}


#Preview {
    StatsView(userID: maria.userID)
        .modelContainer(previewContainer)
}
