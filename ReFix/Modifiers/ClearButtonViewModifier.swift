//
//  ClearButtonViewModifier.swift
//  ReFix
//
//  Created by Ivan Laptii on 09.01.2024.
//

import SwiftUI

struct ClearButtonViewModifier: ViewModifier {
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(text == "" ? 0 : 1)
                .onTapGesture { self.text = "" } // onTapGesture or plainStyle button
        }
    }
}
