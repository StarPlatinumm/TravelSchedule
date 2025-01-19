import SwiftUI
import Combine

struct StoriesView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var progress: CGFloat
    @State private var timer: Timer.TimerPublisher?
    @State private var cancellable: Cancellable?
    
    private var configuration: ProgressBarConfiguration
    private var currentStoryIndex: Int { Int(progress * CGFloat(vM.stories.count)) }
    private var currentStory: Story { vM.stories[currentStoryIndex] }
    
    init(startStoryIndex: Int, storiesCount: Int) {
        progress = CGFloat(startStoryIndex) / CGFloat(storiesCount)
        configuration = ProgressBarConfiguration(storiesCount: storiesCount)
        timer = createTimer()
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(currentStory)
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
            DragGesture(minimumDistance: 20, coordinateSpace: .global)
                .onEnded { value in
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):  nextStory()
                    case (0..., -30...30):  previousStory()
                    case (-100...100, ...0):  print("up swipe")
                    case (-100...100, 0...):  vM.isShowingStories = false
                    default:  print("no clue")
                    }
                }
        )
        
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
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
