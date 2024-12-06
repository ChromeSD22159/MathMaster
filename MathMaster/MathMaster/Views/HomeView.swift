//
//  HomeVIew.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import SwiftUI

struct HomeView: View {
    @Environment(\.currentTheme) var theme
    
    var user: User?
    
    var body: some View {
        VStack{
            Image("headerHome")
                .resizable()
                .scaledToFill()
                .frame(height: 161)
                .ignoresSafeArea(edges: .top)
            
            
            VStack(alignment: .leading, spacing: 20){
                Text("\(user?.name ?? "User"), was möchtest\ndu heute spielen?")
                    .font(.title)
                    .bold()
               
                //Start
                NavigationLink(destination: GameView(user: user)) {
                    ZStack(alignment: .leading) {
                        
                        Image(.PNGMATH)
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        HStack {
                            Spacer()
                            VStack(alignment: .center, spacing: 20) {
                                Text("Kopfrechnen")
                                    .font(.title)
                                
                                ZStack {
                                    Circle()
                                        .fill(Material.ultraThin.opacity(0.55))
                                        .frame(width: 50)
                                    
                                    Image(systemName: "play.fill")
                                        .font(.largeTitle)
                                }
                                
                                
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .cardStyle(color: theme.calculatorSymbolBackgroundColor)
                }//Ende
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            .padding(.top, -30)
        }
    }
}

#Preview {
    HomeView()
}
