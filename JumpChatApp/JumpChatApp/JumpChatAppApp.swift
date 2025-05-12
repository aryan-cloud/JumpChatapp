import SwiftUI // Ensure SwiftUI is imported


@main
struct JumpChatAppApp: App {
    init() {
        LLMService.shared.setup(apiKey: Secrets.openAIKey)
    }

    var body: some Scene {
        WindowGroup {
            ChatView()
        }
    }
}
