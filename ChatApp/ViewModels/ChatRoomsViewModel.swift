//
//  ChatRoomsViewModel.swift
//  Chat
//
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

@Observable
class ChatRoomsViewModel {
    
    var showSignOutAlert = false
    var rooms: [Room] = []
    var addRoom = false
    var selectedRoom: Room?
    var listenerRegistration: ListenerRegistration?
    
    func roomsListener() {
        Firestore.firestore().collection("rooms").addSnapshotListener { querysnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let querySnapshot = querysnapshot else {
                return
            }
            self.rooms = querySnapshot.documents.compactMap({ Room(snapshot: $0) })
        }
    }
    
    func getRooms() async {
        do {
            let result = try await Firestore.firestore().collection("rooms").getDocuments()
            self.rooms = result.documents.compactMap({ Room(snapshot: $0) })
        } catch {
            
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            listenerRegistration?.remove()
            listenerRegistration = nil
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
