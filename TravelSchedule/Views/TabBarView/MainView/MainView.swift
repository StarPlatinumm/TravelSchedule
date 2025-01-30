import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var storiesVM = StoriesVM()
    @ObservedObject private var stationsVM: StationsVM
    @ObservedObject private var routesVM: RoutesVM
    
    init(stationsVM: StationsVM, routesVM: RoutesVM) {
        self.stationsVM = stationsVM
        self.routesVM = routesVM
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(storiesVM.stories) { story in
                            StoryCard(story)
                                .onTapGesture {
                                    storiesVM.onStoryCardTap(story.id)
                                }
                        }
                    }
                }
                .frame(height: 188)
                
                DestinationCardView(stationsVM: stationsVM)
                    .frame(height: 128)
                
                if stationsVM.isAbleToSearchRoutes() {
                    Button("Найти", action: {
                        routesVM.fromStation = stationsVM.fromStation
                        routesVM.toStation = stationsVM.toStation
                        Task {
                            do {
                                try await routesVM.searchRoutes()
                            } catch ErrorType.serverError {
                                navigationVM.path = ["ServerError"]
                            } catch ErrorType.noInternet {
                                navigationVM.path = ["NoInternetError"]
                            } catch {}
                        }
                        navigationVM.path.append("RoutesList")
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
        .fullScreenCover(isPresented: $storiesVM.isShowingStories) {
            StoriesView(storiesVM: storiesVM)
        }
    }
}

#Preview {
    MainView(stationsVM: StationsVM(), routesVM: RoutesVM())
        .environmentObject(NavigationVM())
}
