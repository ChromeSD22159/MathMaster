//
//  ThemeHelper.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//
import SwiftUI

struct ThemeService {
    @AppStorage("Theme") static var theme: String = Theme.mint.rawValue
    
    static func setTheme(_ theme: Theme) {
        ThemeService.theme = theme.rawValue
    }
    
    private static func getTheme() -> Theme {
        Theme(rawValue: theme) ?? .orange
    }
    
    static var currentTheme: Theme {
        ThemeService.getTheme()
    }
}

enum Theme: String, CaseIterable {
    case orange = "Orange"
    case blue = "Blau"
    case mint = "Mint"
    
    var calculatorSymbolBackgroundColor: Color {
        switch self {
            case .orange: return .orange
            case .blue: return .blue
            case .mint: return Color("mint")
        }
    }
    
    var calculatorNumberBackgroundColor: Color {
        switch self {
            case .orange: return .orange
            case .blue: return .yellow
            case .mint: return .mint
        }
    }
    
    var bgGradient: LinearGradient {
        var stops: [Color]
        
        switch self {
            case .orange: stops = [.orange, .red.opacity(0.5)]
            case .blue: stops = [.blue, .purple.opacity(0.5)]
            case .mint: stops = [.mint, .yellow.opacity(0.5)]
        }
        
        return LinearGradient(gradient: Gradient(
            colors: stops),
           startPoint: .topLeading,
           endPoint: .bottomTrailing
        )
    }
}

struct ThemeTest: View {
    @State var theme: Theme = .orange
    
    var body: some View {
        VStack {
            Picker("Theme", selection: $theme) {
                ForEach(Theme.allCases, id: \.rawValue) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: theme, {
                ThemeService.setTheme(theme)
            })
            
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(theme.calculatorNumberBackgroundColor)
                .padding()
        }
        .onAppear {
            theme = ThemeService.currentTheme
        }
    }
}

#Preview {
    ThemeTest()
}
