//
//  ReFixApp.swift
//  ReFix
//
//  Created by Ivan Laptii on 17.12.2023.
//

import SwiftUI
import Firebase

@main
struct ReFixApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
