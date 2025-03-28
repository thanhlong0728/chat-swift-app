//
//  AddRoomViewModel.swift
//  Chat
//
//

import Foundation
import SwiftUI
import FirebaseFirestore

@Observable
class AddRoomViewModel {
    
    var title = ""
    var subTitle = ""
    var alertTitle = ""
    var alertMessage = ""
    var showAlert = false
    
    func createRoom() async -> Bool {
        do {
            try await Firestore.firestore().collection("rooms").addDocument(data: [
                "title": title,
                "subTitle": subTitle
            ])
            return true
        } catch {
            alertTitle = "Error"
            alertMessage = "Could not create a room right now"
            return false
        }
    }
    
}
