//
//  BindingValueModifier.swift
//  ReFix
//
//  Created by Ivan Laptii on 20.01.2024.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    var inversed: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
