import SwiftUI

struct SelectSettlementView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var stationsVM: StationsVM
    @State private var searchText: String = ""
    private let direction: Direction
    
    init(direction: Direction, stationsVM: StationsVM) {
        self.direction = direction
        self.stationsVM = stationsVM
    }
    
    var settlements: [Components.Schemas.Settlement] {
        if searchText.isEmpty {
            return stationsVM.allSettlements ?? []
        } else {
            return stationsVM.allSettlements?.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            } ?? []
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 16)
                if stationsVM.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if !settlements.isEmpty {
                    List(settlements) { settlement in
                        ChevronRowView(text: settlement.title ?? "")
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                stationsVM.setSettlement(direction, value: settlement)
                                stationsVM.setStation(direction, value: nil)
                                navigationVM.path.append("SelectStation\(direction.rawValue)")
                            }
                    }
                    .scrollIndicators(.hidden)
                    .navigationTitle("Выбор города")
                    .listStyle(PlainListStyle())
                } else {
                    NotFoundTextView(text: "Город не найден")
                }
            }
        }
    }
}

#Preview {
    SelectSettlementView(direction: .to, stationsVM: StationsVM())
        .environmentObject(NavigationVM())
}
