//
//  NumberPadView.swift
//  MathMaster
//
//  Created by Robert Laas on 03.12.24.
//

import SwiftUI

struct NumberPadView: View {
    @Environment(\.currentTheme) var theme
    
    @State var number: [Int] = []
    
    var resultCalulated: Int? {
        var resultString: String = ""
        for number in number {
            resultString += String(number)
        }
        
        // Ergebnis-String in einen Integer umwandeln
        if let result = Int(resultString) {
            return result
        } else {
            return 0
        }
    }
    
    var result: (Int) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            
            let buttonWidth = geometry.size.width / 6
            
            VStack {
                
                // MARK: - Eingabe Anzeige
                
                HStack {
                    Spacer()
                    if let resultCalulated = resultCalulated {
                        Text("\(resultCalulated)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                .padding(40)
                
                
                // MARK: - NumberBlock
                HStack {
                    Grid {
                        GridRow {
                            ForEach(7..<10) { number in
                                NumberPadItem(String(number), size: buttonWidth) { resultNumber in
                                    if let resultNumber = resultNumber {
                                        self.number.append(resultNumber)
                                    }
                                }
                            }
                        }
                        
                        GridRow {
                            ForEach(4..<7) { number in
                                NumberPadItem(String(number), size: buttonWidth) { resultNumber in
                                    if let resultNumber = resultNumber {
                                        self.number.append(resultNumber)
                                    }
                                }
                            }
                        }
                        
                        GridRow(alignment: .center) {
                            ForEach(1..<4) { number in
                                NumberPadItem(String(number), size: buttonWidth) { resultNumber in
                                    if let resultNumber = resultNumber {
                                        self.number.append(resultNumber)
                                    }
                                }
                            }
                        }
                        
                        GridRow {
                            NumberPadItem("<", color: theme.calculatorSymbolBackgroundColor, size: buttonWidth){ number in
                                resetNumberArray()
                            }
                            
                            NumberPadItem("0", size: buttonWidth) { resultNumber in
                                if let resultNumber = resultNumber {
                                    self.number.append(resultNumber)
                                }
                            }
                            
                            NumberPadItem("=", color: theme.calculatorSymbolBackgroundColor, size: buttonWidth) { number in
                                if let resultCalulated = resultCalulated {
                                    result(resultCalulated)
                                    resetNumberArray()
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                
                
                Spacer()
            }
        }
    }
    
    func resetNumberArray() {
        number = []
    }
}

struct NumberPadItem: View {
    @Environment(\.currentTheme) var theme
    
    let text: String
    let color: Color
    let size: CGFloat
    let result: (Int?) -> Void
    
    init(_ text: String, color: Color = ThemeService.currentTheme.calculatorNumberBackgroundColor, size: CGFloat = 80, result: @escaping (Int?) -> Void) {
        self.text = text
        self.color = color
        self.size = size
        self.result = result
    }
    
    var body: some View {
        Text(text)
            .frame(width: size, height: size)
            .background(color)
            .clipShape(Circle())
            .onTapGesture {
                result(Int(text))
            }
    }
}

#Preview {
    NumberPadView(result: {_ in
        
    })
    .environment(\.currentTheme, .orange)
} 
