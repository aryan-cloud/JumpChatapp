import Foundation

enum Sender {
    case user, assistant
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: Sender
    let content: String
    var isStreaming: Bool = false
}
