//
//  NumberPadView.swift
//  MathMaster
//
//  Created by Robert Laas on 03.12.24.
//

import SwiftUI

struct NumberPadView: View {
    
    var calculationResult: (Int) -> Void
    
    var body: some View {
        Grid {
            GridRow {
                NumberPadItem("1")
                NumberPadItem("2")
                NumberPadItem("3")
                
            }
            
            GridRow {
                NumberPadItem("4")
                NumberPadItem("5")
                NumberPadItem("6")
                
            }
            
            GridRow {
                NumberPadItem("7")
                NumberPadItem("8")
                NumberPadItem("9")
                
            }
            
            GridRow {
                NumberPadItem("<-")
                NumberPadItem("0")
                NumberPadItem("=")
                
                
            }
        }
    }
}

struct NumberPadItem: View {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        
        Text(text)
    
    }
}

#Preview {
    NumberPadView(calculationResult: {_ in})
}
