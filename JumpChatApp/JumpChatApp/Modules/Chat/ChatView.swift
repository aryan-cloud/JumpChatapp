import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @FocusState private var isFocused: Bool
    @State private var inputHeight: CGFloat = 40

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            messageView(for: message)
                                .id(message.id)
                        }

                        if viewModel.isThinking {
                            thinkingView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    withAnimation {
                        proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                    }
                }
            }

            Divider()

            HStack(alignment: .bottom) {
                GrowingTextView(text: $viewModel.inputText, height: $inputHeight)
                    .frame(height: inputHeight)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3))
                    )
                    .focused($isFocused)

                Button {
                    viewModel.sendMessage()
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                }
                .padding(.leading, 4)
            }
            .padding()
        }
        .navigationTitle("Jump Chat")
        .onTapGesture {
            isFocused = false
        }
    }

    @ViewBuilder
    private func messageView(for message: ChatMessage) -> some View {
        HStack {
            if message.sender == .user {
                Spacer()
                Text(message.content)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(16)
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                Text(message.content)
                    .padding(12)
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func thinkingView() -> some View {
        Text("Thinking…")
            .italic()
            .padding(12)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .frame(maxWidth: 250, alignment: .leading)
    }
}
