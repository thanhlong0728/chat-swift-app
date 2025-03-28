//
//  ChatThreadViewModel.swift
//  Chat
//
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@Observable
class ChatThreadViewModel {
    
    var chatText = ""
    var currentUserId: String = {
        return Auth.auth().currentUser?.uid ?? ""
    }()
    var chats: [Chat] = []
    var sortedChats: [Chat] {
       return chats.sorted(by: { $0.createdAt < $1.createdAt })
    }
    var listenerRegistration: ListenerRegistration?
    let room: Room
    
    init(room: Room) {
        self.room = room
    }
    
    func createChat() {
        Firestore.firestore().collection("chats").addDocument(data: ["userId": currentUserId, "text": chatText, "roomId": room.id, "createdAt": Date().timeIntervalSince1970])
        chatText = ""
    }
    
    func stopChatsListener() {
        listenerRegistration?.remove()
        listenerRegistration = nil
    }
    
    func listenToChats() {
        listenerRegistration = Firestore.firestore().collection("chats").whereField("roomId", isEqualTo: room.id).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                return
            }
            self.chats = snapshot.documents.compactMap({ Chat(snapshot: $0) })
        }
    }
    
}
