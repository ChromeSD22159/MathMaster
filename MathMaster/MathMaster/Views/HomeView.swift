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
        ZStack(alignment: .top) {
            // MARK: - Background
            VStack {
                Image("headerGreen")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 161)
                    .ignoresSafeArea(edges: .top)
                
                Spacer()
            }
            
            // MARK: - ViewContent
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    Text("\(user?.name ?? "UserName"), was möchtest\ndu heute spielen?")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 30)
                    
                    
                    Card(user: user)
                    
                }
            }
            .contentMargins([.top], 75)
        }
    }
    
    private struct Card: View {
        @Environment(\.currentTheme) var theme
        let user: User?
        var body: some View {
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
            }
        }
    }
}

#Preview {
    HomeView()
}
