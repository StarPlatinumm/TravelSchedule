import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var searchText: String = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var stations: [Components.Schemas.Station] {
        if searchText.isEmpty {
            return vM.currentStations ?? []
        } else {
            return vM.currentStations?.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            } ?? []
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 16)
                if !stations.isEmpty {
                    List(stations) { item in
                        ChevronRowView(text: item.title ?? "")
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                vM.setStation(direction, value: item)
                                vM.path = []
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
    SelectStationView(direction: .to)
        .environmentObject(MainVM())
}
