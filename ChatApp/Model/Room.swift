//
//  Room.swift
//  Chat
//
//

import Foundation
import FirebaseFirestore

struct Room: Identifiable, Hashable {
    
    let id: String
    let title: String
    let subtitle: String
    
    init(id: String, title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
    
    init?(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        guard let title = data["title"] as? String else {
            return nil
        }
        guard let subtitle = data["subTitle"] as? String else {
            return nil
        }
        self.id = snapshot.documentID
        self.title = title
        self.subtitle = subtitle
    }
    
}
