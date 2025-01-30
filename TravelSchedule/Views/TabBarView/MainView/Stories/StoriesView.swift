import SwiftUI
import Combine

struct StoriesView: View {
    @ObservedObject private var storiesVM: StoriesVM
    @State private var progress: CGFloat
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
    
    private var configuration: ProgressBarConfiguration
    private var currentStoryIndex: Int { Int(progress * CGFloat(storiesVM.stories.count)) }
    private var currentStory: Story { storiesVM.stories[currentStoryIndex] }
    
    init(storiesVM: StoriesVM) {
        self.storiesVM = storiesVM
        progress = CGFloat(storiesVM.startStoryIndex) / CGFloat(storiesVM.stories.count)
        configuration = ProgressBarConfiguration(storiesCount: storiesVM.stories.count)
        timer = createTimer()
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(currentStory)
            ProgressBar(numberOfSections: storiesVM.stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton(action: { storiesVM.isShowingStories = false })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            timer = createTimer()
            cancellable = timer?.connect()
            storiesVM.markStoryAsSeen(storyId: currentStory.id)
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer ?? createTimer()) { _ in
            timerTick()
        }
        .onChange(of: currentStory) { story in
            storiesVM.markStoryAsSeen(storyId: story.id)
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
            DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded { value in
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):  nextStory()
                    case (0..., -30...30):  previousStory()
                    case (-100...100, ...0):  print("up swipe")
                    case (-100...100, 0...):  storiesVM.isShowingStories = false
                    default:  print("no clue")
                    }
                }
        )
        
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            storiesVM.isShowingStories = false
        } else {
            withAnimation {
                progress = nextProgress
            }
        }
    }
    
    private func previousStory() {
        let newStoryIndex = max(0, currentStoryIndex - 1)
        withAnimation {
            progress = CGFloat(newStoryIndex) / CGFloat(storiesVM.stories.count)
        }
    }
    
    private func nextStory() {
        let newStoryIndex = currentStoryIndex + 1
        if newStoryIndex  == storiesVM.stories.count {
            storiesVM.isShowingStories = false
        } else {
            withAnimation {
                progress = CGFloat(newStoryIndex) / CGFloat(storiesVM.stories.count)
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
    StoriesView(storiesVM: StoriesVM())
}
