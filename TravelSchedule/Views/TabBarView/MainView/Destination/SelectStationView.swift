import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var searchText = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 16)
                List(vM.getStations(direction: direction)) { item in
                    ChevronRowView(text: item.name)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            vM.setStation(direction, value: item)
                            vM.path = []
                        }
                }
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
                .navigationTitle("Выбор станции")
            }
        }
    }
}

#Preview {
    SelectStationView(direction: .to)
        .environmentObject(MainVM())
}
