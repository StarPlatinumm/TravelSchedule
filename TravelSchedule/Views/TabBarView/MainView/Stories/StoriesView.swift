import SwiftUI
import Combine

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

struct StoriesView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var progress: CGFloat
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
    
    private var configuration: StoriesConfiguration
    private var currentStoryIndex: Int { Int(progress * CGFloat(vM.stories.count)) }
    private var currentStory: Story { vM.stories[currentStoryIndex] }
    
    init(startStoryIndex: Int, storiesCount: Int) {
        progress = CGFloat(startStoryIndex) / CGFloat(storiesCount)
        configuration = StoriesConfiguration(storiesCount: storiesCount)
        timer = createTimer()
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: getCurrentStory())
            ProgressBar(numberOfSections: vM.stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: { vM.isShowingStories = false })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            timer = createTimer()
            cancellable = timer?.connect()
            vM.markStoryAsSeen(storyId: currentStory.id)
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer ?? createTimer()) { _ in
            timerTick()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
        .onChange(of: currentStory) { story in
            vM.markStoryAsSeen(storyId: story.id)
        }
    }
    
    private func getCurrentStory() -> Story {
        let currentStoryIndex = Int(progress * CGFloat(vM.stories.count))
        let currentStory = vM.stories[currentStoryIndex]
        return currentStory
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        let storiesCount = vM.stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = createTimer()
        cancellable = timer?.connect()
    }
    
    private func createTimer() -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    StoriesView(startStoryIndex: MainVM().startStoryIndex, storiesCount: MainVM().stories.count)
        .environmentObject(MainVM())
}
