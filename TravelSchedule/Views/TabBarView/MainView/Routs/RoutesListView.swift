import SwiftUI

struct RoutesListView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("\(vM.fromStation?.title ?? "") → \(vM.toStation?.title ?? "")")
                    .font(.system(size: 24, weight: .bold))
                
                if vM.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let routes = vM.filteredRoutes {
                    List(routes) { route in
                        RouteCardView(route: route)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            .onTapGesture {
                                vM.currentCarrier = route.thread?.carrier
                                vM.path.append("CarrierInfo")
                            }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())
                    .safeAreaInset(edge: .bottom) {
                        Button(action: {
                            vM.path.append("RoutesFilters")
                        }) {
                            HStack {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                if !vM.departureTimeSelected.isEmpty {
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
    RoutesListView()
        .environmentObject(MainVM())
}
