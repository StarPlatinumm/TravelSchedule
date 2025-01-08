import SwiftUI

struct SelectSettlementView: View {
    @EnvironmentObject private var pathData: PathData
    @EnvironmentObject private var stationSelectionVM: StationSelectionVM
    @State private var searchText = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .padding(.bottom, 16)
            List(Array(stationSelectionVM.data.keys)) { settlement in
                ChevronRowView(text: settlement.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        stationSelectionVM.setSettlement(direction, value: settlement)
                        stationSelectionVM.setStation(direction, value: nil)
                        pathData.path.append("SelectStation\(direction.rawValue)")
                    }
            }
            .navigationTitle("Выбор города")
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SelectSettlementView(direction: .to)
        .environmentObject(PathData())
        .environmentObject(StationSelectionVM())
}
