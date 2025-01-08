import SwiftUI

struct SelectSettlementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vM: StationSelectionVM
    @State private var searchText = ""
    @State private var selectedCity: String?
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                CustomNavigationBar(text: "Выберите город", backButtonAction: { self.presentationMode.wrappedValue.dismiss() } )
                SearchBar(searchText: $searchText)
                    .frame(height: 100)
                List(Array(vM.data.keys)) { settlement in
                    ZStack(alignment: .leading) {
                        ChevronRowView(text: settlement.name)
                        NavigationLink(value: settlement) { EmptyView() }
                    }
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        vM.fromStation = settlement.name
                    }
                }
                .navigationDestination(for: Settlement.self) { settlement in
                    SelectStationView(stations: vM.data[settlement]!)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

#Preview {
    SelectSettlementView()
        .environmentObject(StationSelectionVM())
}
