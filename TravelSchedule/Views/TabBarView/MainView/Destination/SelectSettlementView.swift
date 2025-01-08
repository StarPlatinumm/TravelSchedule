import SwiftUI

struct SelectSettlementView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var searchText = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .padding(.bottom, 16)
            List(Array(vM.data.keys)) { settlement in
                ChevronRowView(text: settlement.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        vM.setSettlement(direction, value: settlement)
                        vM.setStation(direction, value: nil)
                        vM.path.append("SelectStation\(direction.rawValue)")
                    }
            }
            .navigationTitle("Выбор города")
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SelectSettlementView(direction: .to)
        .environmentObject(MainVM())
}
