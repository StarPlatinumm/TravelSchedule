import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var stationsVM: StationsVM
    @State private var searchText: String = ""
    private let direction: Direction
    
    init(direction: Direction, stationsVM: StationsVM) {
        self.direction = direction
        self.stationsVM = stationsVM
    }
    
    var stations: [Components.Schemas.Station] {
        if searchText.isEmpty {
            return stationsVM.currentStations ?? []
        } else {
            return stationsVM.currentStations?.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            } ?? []
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 16)
                if !stations.isEmpty {
                    List(stations) { item in
                        ChevronRowView(text: item.title ?? "")
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                stationsVM.setStation(direction, value: item)
                                navigationVM.path = []
                            }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())
                    .navigationTitle("Выбор станции")
                } else {
                    NotFoundTextView(text: "Станция не найдена")
                }
            }
        }
    }
}

#Preview {
    SelectStationView(direction: .to, stationsVM: StationsVM())
        .environmentObject(NavigationVM())
}
