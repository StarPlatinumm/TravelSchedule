import SwiftUI
import Combine

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
            StoryView(story: currentStory)
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
        .onChange(of: currentStory) { story in
            vM.markStoryAsSeen(storyId: story.id)
        }
        .onTapGesture {gestureLocation in
            let screenWidth = UIScreen.main.bounds.width
            let tapPosition = gestureLocation.x
            
            if tapPosition < screenWidth / 2 {
                previousStory()
            } else {
                nextStory()
            }
            resetTimer()
        }
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width < 0 {
                        nextStory()
                    } else if gesture.translation.width > 0 {
                        previousStory()
                    }
                }
        )
        
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            vM.isShowingStories = false
        } else {
            withAnimation {
                progress = nextProgress
            }
        }
    }
    
    private func previousStory() {
        let newStoryIndex = max(0, currentStoryIndex - 1)
        withAnimation {
            progress = CGFloat(newStoryIndex) / CGFloat(vM.stories.count)
        }
    }
    
    private func nextStory() {
        let newStoryIndex = currentStoryIndex + 1
        if newStoryIndex  == vM.stories.count {
            vM.isShowingStories = false
        } else {
            withAnimation {
                progress = CGFloat(newStoryIndex) / CGFloat(vM.stories.count)
            }
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
