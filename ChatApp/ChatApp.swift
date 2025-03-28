//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Mac on 27/03/2025.
//

import SwiftUI
import FirebaseCore

@main
struct ChatApp: App {
    
    @State var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.sessionState {
            case .loggedIn:
                ChatRoomsView()
                    .environment(sessionManager)
            case .loggedOut:
                LoginView()
                    .environment(sessionManager)
            }
        }
    }
}
