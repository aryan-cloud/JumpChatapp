import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var isThinking = false

    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = ChatMessage(sender: .user, content: inputText)
        messages.append(userMessage)
        inputText = ""
        isThinking = true

        Task {
            try await fetchLLMResponse(for: userMessage.content)
        }
    }

    private func fetchLLMResponse(for prompt: String) async throws {
        // Temporary mock delay (replace with OpenAI later)
        try await Task.sleep(nanoseconds: 2_000_000_000)

        let assistantMessage = ChatMessage(sender: .assistant, content: "Mock reply for: \(prompt)")
        messages.append(assistantMessage)
        isThinking = false
    }
}
