import SwiftUI

struct Story: Identifiable, Equatable {
    let id: UUID
    let img: Image
    let title: String
    let description: String
    var isSeen: Bool
    
    init(
        img: Image,
        title: String = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
        description: String = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
        isSeen: Bool = false) {
            id = UUID()
            self.img = img
            self.title = title
            self.description = description
            self.isSeen = isSeen
    }

    static let mockStories = [
        Story(img: Image("story-img-1")),
        Story(img: Image("story-img-2")),
        Story(img: Image("story-img-3")),
        Story(img: Image("story-img-4")),
        Story(img: Image("story-img-5")),
        Story(img: Image("story-img-6")),
    ]
}

struct StoriesConfiguration {
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
