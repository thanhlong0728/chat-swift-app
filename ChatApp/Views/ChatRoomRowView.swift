//
//  ChatRoomRowView.swift
//  Chat
//
//

import Foundation
import SwiftUI

struct ChatRoomRowView: View {
    let room: Room
    var body: some View {
        VStack(alignment: .leading) {
            Text(room.title)
                .foregroundStyle(.black)
                .font(.system(size: 15, weight: .semibold))
                .padding(.bottom, 2)
            Text(room.subtitle)
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 3)
    }
}
