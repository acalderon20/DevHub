//
//  ConversationView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/25/24.
//

import SwiftUI

struct ConversationView: View {
    @State private var prompt: String = ""
    @State private var isEditing: Bool = false
    
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            title
            Spacer()
            conversationView

            Spacer()
            footer
        }
    }
    var title: some View {
        Text("Message a Dev!")
            .padding()
    }
    
    func contextMenuItem(title: String, imageName: String) -> some View {
        Button(action: {
            // Placeholder for future action
        }) {
            HStack {
                Text(title)
                Image(systemName: imageName)
            }
        }
    }

    var conversationView: some View {
        ScrollView {
            ForEach(viewModel.messages.indices, id: \.self) { index in
                let isUser = viewModel.messages[index].sender == .user
                let isLastAndTyping = index == viewModel.messages.count - 1 && viewModel.isTypingEffectActive
                let messageContent = isLastAndTyping ? viewModel.displayedText : viewModel.messages[index].content

                MessageView(isUser: isUser, messageContent: messageContent)
                }
            }
        }
    
    
    var footer: some View {
        HStack {
            promptField

        }
        .padding(.horizontal, 10)
    }
    
    var promptField: some View {
        TextField("Message...", text: $prompt)
            .tint(.gray)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .overlay(
                Capsule()
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .onSubmit {
                viewModel.sendRequest(with: prompt)
                prompt = ""
            }
    .padding(10)
    }
}


struct MessageView: View {
    var isUser: Bool
    var messageContent: String
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            
            Text(messageContent)
                .padding(10)
                .foregroundColor(.white)
                .background(isUser ? Color.blue : Color.green)
                .cornerRadius(10)
                .fixedSize(horizontal: false, vertical: true)
            
            if !isUser {
                Spacer()
            }
        }
    }
}



#Preview {
    ConversationView()
}
