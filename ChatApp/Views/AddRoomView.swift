//
//  AddRoomView.swift
//  Chat
//
//

import SwiftUI

struct AddRoomView: View {
    
    @State var viewModel = AddRoomViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 30)
            TextField("Title", text: $viewModel.title)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 5)
            Text("Subtitle")
                .font(.system(size: 15, weight: .semibold))
            TextField("Subtitle", text: $viewModel.subTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            Button(action: {
                Task {
                    let result = await viewModel.createRoom()
                    if result {
                        dismiss()
                    }
                }
            }, label: {
                Text("Create Room")
            })
            .buttonStyle(PrimaryButtonStyle())
            Spacer()
        }
        .padding(.horizontal)
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(viewModel.alertMessage)
        }

    }
}

#Preview {
    AddRoomView()
}
