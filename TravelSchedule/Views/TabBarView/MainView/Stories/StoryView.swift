import SwiftUI

struct StoryView: View {
    private let story: Story
    
    init(_ story: Story) {
        self.story = story
    }
    
    var body: some View {
        ZStack {
            story.img
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
            }
        }
    }
}

#Preview {
    StoryView(Story.mockStories[0])
}
