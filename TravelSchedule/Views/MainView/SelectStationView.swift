import SwiftUI

struct SelectStationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vM: StationSelectionVM
    @State private var searchText = ""
    @State var stations: [Station]
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .frame(height: 100)
            List(stations) { item in
                ChevronRowView(text: item.name)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        vM.fromStation = "\(vM.fromStation) (\(item.name))"
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SelectStationView(stations: [
        Station(name: "Киевский вокзал"),
        Station(name: "Курский вокзал"),
        Station(name: "Ярославский вокзал"),
        Station(name: "Белорусский вокзал"),
        Station(name: "Савёловский вокзал")
    ])
    .environmentObject(StationSelectionVM())
}
