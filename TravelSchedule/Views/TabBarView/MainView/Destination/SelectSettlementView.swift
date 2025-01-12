import SwiftUI

struct SelectSettlementView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var searchText: String = ""
    private let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var filteredSettlements: [Components.Schemas.Settlement]? {
        if searchText.isEmpty {
            return vM.allSettlements
        } else {
            return vM.allSettlements?.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 16)
                if vM.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    if let settlements = filteredSettlements {
                        List(settlements) { settlement in
                            ChevronRowView(text: settlement.title ?? "")
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    vM.setSettlement(direction, value: settlement)
                                    vM.setStation(direction, value: nil)
                                    vM.path.append("SelectStation\(direction.rawValue)")
                                }
                        }
                        .scrollIndicators(.hidden)
                        .navigationTitle("Выбор города")
                        .listStyle(PlainListStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    SelectSettlementView(direction: .to)
        .environmentObject(MainVM())
}
