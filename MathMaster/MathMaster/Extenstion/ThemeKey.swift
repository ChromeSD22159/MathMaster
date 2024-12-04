//
//  ThemeKey.swift
//  MathMaster
//
//  Created by Frederik Kohler on 04.12.24.
//

import SwiftUI
 
struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = ThemeService.currentTheme
}

extension EnvironmentValues {
    var currentTheme: Theme {
        get { ThemeService.currentTheme }
        set { ThemeService.setTheme(newValue) }
    }
}
