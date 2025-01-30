import SwiftUI

struct RoutesListView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var routesVM: RoutesVM
    @ObservedObject private var filterVM: FilterVM
    
    init(routesVM: RoutesVM, filterVM: FilterVM) {
        self.routesVM = routesVM
        self.filterVM = filterVM
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("\(routesVM.fromStation?.title ?? "") → \(routesVM.toStation?.title ?? "")")
                    .font(.system(size: 24, weight: .bold))
                
                if routesVM.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let routes = routesVM.filteredRoutes {
                    List(routes) { route in
                        RouteCardView(route: route)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            .onTapGesture {
                                routesVM.currentCarrier = route.thread?.carrier
                                navigationVM.path.append("CarrierInfo")
                            }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())
                    .safeAreaInset(edge: .bottom) {
                        Button(action: {
                            navigationVM.path.append("RoutesFilters")
                        }) {
                            HStack {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                if !filterVM.departureTimeSelected.isEmpty {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.ypRed)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .font(.system(size: 17, weight: .bold))
                        .background(.ypBlue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom, 8)
                    }
                } else {
                    NotFoundTextView(text: "Вариантов нет")
                }
            }
            .padding()
        }
    }
}

#Preview {
    RoutesListView(routesVM: RoutesVM(), filterVM: FilterVM())
        .environmentObject(NavigationVM())
}
