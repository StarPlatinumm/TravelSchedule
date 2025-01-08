import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject var contentViewVM: ContentViewVM
    @EnvironmentObject var stationSelectionVM: StationSelectionVM
    @State private var searchText = ""
    let direction: Direction
    
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .frame(height: 100)
            List(stationSelectionVM.getStations(direction: direction)) { item in
                ChevronRowView(text: item.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        stationSelectionVM.setStation(direction, value: item)
                        contentViewVM.path = []
                    }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Выберите станцию")
        }
    }
}

#Preview {
    SelectStationView(direction: .to)
    .environmentObject(StationSelectionVM())
}
