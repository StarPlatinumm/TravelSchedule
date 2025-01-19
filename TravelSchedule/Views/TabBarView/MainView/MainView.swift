import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(vM.stories) { story in
                            StoryCard(story: story)
                                .onTapGesture {
                                    vM.onStoryCardTap(story.id)
                                }
                        }
                    }
                }
                .frame(height: 188)
                
                DestinationCardView()
                    .frame(height: 128)
                
                if vM.isAbleToSearchRoutes() {
                    Button("Найти", action: {
                        vM.isLoading = true
                        Task {
                            await vM.searchRoutes()
                        }
                        vM.path.append("RoutesList")
                    })
                    .font(.system(size: 17, weight: .bold))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 48)
                    .background(.ypBlue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $vM.isShowingStories) {
            StoriesView(startStoryIndex: vM.startStoryIndex, storiesCount: vM.stories.count)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MainVM())
}
