import SwiftUI

struct SelectStationView: View {
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .imageScale(.large)
                .font(.system(size: 17, weight: .semibold))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .frame(height: 100)
                List {
                    ForEach(0..<100) { index in
                        ChevronRowView(text: "Item \(index)")
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: btnBack)
        .navigationTitle("Выберите город")
    }
}

#Preview {
    SelectStationView()
}
