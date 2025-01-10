import SwiftUI

struct RoutsListView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)")
                    .font(.system(size: 24, weight: .bold))
                ZStack {
                    List {
                        ForEach(0..<10) { index in
                            RoutCardView()
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                                .onTapGesture {
                                    vM.path.append("CarrierInfo")
                                }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())
                    .safeAreaInset(edge: .bottom) {
                        Button(action: {
                            vM.path.append("RoutsFilters")
                        }) {
                            HStack {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.ypRed)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .font(.system(size: 17, weight: .bold))
                        .background(.ypBlue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom, 8)
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    RoutsListView()
        .environmentObject(MainVM())
}
