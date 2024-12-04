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
        NavigationLink(destination: GameView(user: user)) {
            ZStack(alignment: .leading) {
                
                Image(.PNGMATH)
                    .resizable()
                    .frame(width: 150, height: 150)
                
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 20) {
                        Text("Play Math Master")
                        
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
        }
    }
}

#Preview {
    HomeView()
}
