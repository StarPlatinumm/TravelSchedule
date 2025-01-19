import SwiftUI

struct StoryCard: View {
    private let story: Story
    
    init(_ story: Story) {
        self.story = story
    }
    
    var body: some View {
        ZStack {
            story.img.resizable()
            VStack {
                Spacer()
                Text(story.title)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
            }
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(.ypBlue, lineWidth: story.isSeen ? 0 : 4)
                .background(story.isSeen ? .white.opacity(0.3) : .white.opacity(0))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        )
    }
}

#Preview {
    StoryCard(Story.mockStories[0])
}
