import SwiftUI

struct RoutesFiltersView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var filterVM: FilterVM
    @ObservedObject private var routesVM: RoutesVM
    
    init(filterVM: FilterVM, routesVM: RoutesVM) {
        self.filterVM = filterVM
        self.routesVM = routesVM
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    CheckboxRowView(departureTimeSelected: $filterVM.departureTimeSelected, departureTime: .morning)
                    CheckboxRowView(departureTimeSelected: $filterVM.departureTimeSelected, departureTime: .afternoon)
                    CheckboxRowView(departureTimeSelected: $filterVM.departureTimeSelected, departureTime: .evening)
                    CheckboxRowView(departureTimeSelected: $filterVM.departureTimeSelected, departureTime: .night)
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    RadioButtonRowView(transfersAllowed: $filterVM.transfersAllowed, value: true)
                    RadioButtonRowView(transfersAllowed: $filterVM.transfersAllowed, value: false)
                }
                
                Spacer()
                
                Button("Применить", action: {
                    routesVM.filterRoutes(departureTimeFilter: filterVM.departureTimeSelected, transfersAllowed: filterVM.transfersAllowed)
                    navigationVM.path.removeLast()
                })
                .frame(maxWidth: .infinity, minHeight: 60)
                .font(.system(size: 17, weight: .bold))
                .background(.ypBlue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 8)
            }
            .padding()
        }
    }
}

#Preview {
    RoutesFiltersView(filterVM: FilterVM(), routesVM: RoutesVM())
        .environmentObject(NavigationVM())
}
