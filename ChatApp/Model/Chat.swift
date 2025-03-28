//
//  Chat.swift
//  Chat
//
//

import Foundation
import FirebaseFirestore

struct Chat: Identifiable {
    let id: String
    let userId: String
    let text: String
    let createdAt: Date
    
    init(id: String, userId: String, text: String) {
        self.id = id
        self.userId = userId
        self.text = text
        self.createdAt = Date()
    }
    
    init?(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        guard let userId = data["userId"] as? String else { return nil }
        guard let text = data["text"] as? String else { return nil }
        guard let createdAt = data["createdAt"] as? Double else { return nil }
        self.id = snapshot.documentID
        self.userId = userId
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: createdAt)
    }
}
