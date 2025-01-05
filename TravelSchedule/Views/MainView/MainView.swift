import SwiftUI

struct MainView: View {
    @State var from: String? = "123"
    @State var to: String? = "123"
    
    func onSearch() {
        //
    }

    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0..<8) { index in
                            ZStack {
                                
                            }
                            .frame(width: 92, height: 140)
                            .background(.ypGray)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .frame(height: 188)
                
                RouteCard()
                
                if from != nil && to != nil {
                    Button("Найти", action: onSearch)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 48)
                        .background(.ypBlue)
                        .foregroundStyle(.ypWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    MainView()
}
