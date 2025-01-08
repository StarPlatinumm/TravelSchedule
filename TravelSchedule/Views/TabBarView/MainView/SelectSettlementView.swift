import SwiftUI

struct SelectSettlementView: View {
    @EnvironmentObject var contentViewVM: ContentViewVM
    @EnvironmentObject var stationSelectionVM: StationSelectionVM
    @State private var searchText = ""
    @State private var selectedCity: String?
    let direction: Direction
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .frame(height: 100)
            List(Array(stationSelectionVM.data.keys)) { settlement in
                ChevronRowView(text: settlement.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        stationSelectionVM.setSettlement(direction, value: settlement)
                        stationSelectionVM.setStation(direction, value: nil)
                        contentViewVM.path.append("SelectStation\(direction.rawValue)")
                    }
            }
            .navigationTitle("Выберите город")
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SelectSettlementView(direction: .to)
        .environmentObject(ContentViewVM())
        .environmentObject(StationSelectionVM())
}
