import SwiftUI

struct StoryCard: View {
    @EnvironmentObject private var vM: MainVM
    let story: Story
    
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
        .onTapGesture {
            vM.isShowingStories = true
            vM.startStoryIndex = vM.stories.firstIndex(where: { $0.id == story.id }) ?? 0
        }
    }
}

#Preview {
    StoryCard(story: Story.mockStories[0])
        .environmentObject(MainVM())
}
