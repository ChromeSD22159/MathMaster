//
//  NumberPadView.swift
//  MathMaster
//
//  Created by Robert Laas on 03.12.24.
//

import SwiftUI

struct NumberPadView: View {
    
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
           return 0 // Oder eine andere Fehlerbehandlung
       }
    }
    
    var result: (Int) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            
            let buttonWidth = geometry.size.width / 4.5
            
            VStack {
                
                // MARK: - Eingabe Anzeige
                Spacer()
                HStack {
                    Spacer()
                    if let resultCalulated = resultCalulated {
                        Text("\(resultCalulated)").fontWeight(.bold)
                    }
                }
                .cardStyle()
                
                
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
                            NumberPadItem("<", color: .yellow, size: buttonWidth){ number in
                                resetNumberArray()
                            }
                            
                            NumberPadItem("0", size: buttonWidth) { resultNumber in
                                if let resultNumber = resultNumber {
                                    self.number.append(resultNumber)
                                }
                            }
                            
                            NumberPadItem("=", color: .yellow, size: buttonWidth) { number in
                                if let resultCalulated = resultCalulated {
                                    result(resultCalulated)
                                    resetNumberArray()
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                .cardStyle() 
                
                Spacer()
            }
        }
    }
    
    func resetNumberArray() {
        number = []
    }
}

struct NumberPadItem: View {
    
    let text: String
    let color: Color
    let size: CGFloat
    let result: (Int?) -> Void
    
    init(_ text: String, color: Color = .blue, size: CGFloat = 80, result: @escaping (Int?) -> Void) {
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
}
