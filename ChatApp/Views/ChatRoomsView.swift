//
//  ChatRoomsView.swift
//  Chat
//
//

import SwiftUI

struct ChatRoomsView: View {
    
    @State var viewModel = ChatRoomsViewModel()
    @Environment(SessionManager.self) var sessionManager: SessionManager
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.rooms) { room in
                    Button(action: {
                        viewModel.selectedRoom = room
                    }, label: {
                        ChatRoomRowView(room: room)
                    })
                }
            }
            .navigationDestination(item: $viewModel.selectedRoom, destination: { room in
                ChatThreadView(room: room)
            })
            .onAppear(perform: {
                viewModel.roomsListener()
            })
            .navigationTitle("Rooms")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.addRoom = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showSignOutAlert = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    })
                }
            }
            .alert("Are you sure you would like to sign out?", isPresented: $viewModel.showSignOutAlert) {
                Button("Sign Out", role: .destructive) {
                    if viewModel.signOut() {
                        sessionManager.sessionState = .loggedOut
                    }
                }
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        .sheet(isPresented: $viewModel.addRoom, content: {
            AddRoomView()
        })
    }
}

#Preview {
    ChatRoomsView()
}
