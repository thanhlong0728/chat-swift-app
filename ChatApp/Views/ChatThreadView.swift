//
//  ChatThreadView.swift
//  Chat
//
//

import SwiftUI
import FirebaseFirestore

struct ChatThreadView: View {
    
    @State var viewModel: ChatThreadViewModel
    
    init(room: Room) {
        viewModel = ChatThreadViewModel(room: room)
    }
    
    private func SentMessage(chat: Chat) -> some View {
        HStack{
            Spacer()
            Text(chat.text)
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .padding(.trailing)
                .padding(.leading, 55)
        }
    }
    
    private func RecievedMessage(chat: Chat) -> some View {
        HStack{
            Text(chat.text)
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .padding(.trailing, 55)
                .padding(.leading)
            Spacer()
        }
    }
    
    private var ChatBottomBar: some View {
        HStack{
            TextEditor(text: $viewModel.chatText)
                .frame(height: 40)
                .background(Color(uiColor: UIColor.lightGray.withAlphaComponent(0.3)))
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading)
            Button(action: {
                viewModel.createChat()
            }, label: {
                Text("Send")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
            })
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.sortedChats) { chat in
                        if chat.userId == viewModel.currentUserId {
                            SentMessage(chat: chat)
                        }
                        else {
                            RecievedMessage(chat: chat)
                        }
                    }
                }
            }
            Spacer()
            ChatBottomBar
                  .padding(.bottom)
        }
        .onDisappear(perform: {
            viewModel.stopChatsListener()
        })
        .onAppear(perform: {
            viewModel.listenToChats()
        })
    }
}

#Preview {
    ChatThreadView(room: Room(id: "32jjh42", title: "Test", subtitle: "Test"))
}
