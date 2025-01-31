import SwiftUI

// Логика и данные для историй
@MainActor
final class StoriesVM: ObservableObject {
    @Published var stories: [Story] = Story.mockStories
    @Published var startStoryIndex: Int = 0
    @Published var isShowingStories: Bool = false
    
    func markStoryAsSeen(storyId: UUID) {
        if let index = stories.firstIndex(where: { $0.id == storyId }) {
            stories[index].isSeen = true
        }
    }
    
    func onStoryCardTap(_ storyId: UUID) {
        if let index = stories.firstIndex(where: { $0.id == storyId }) {
            startStoryIndex = index
            isShowingStories = true
        }
    }
}
