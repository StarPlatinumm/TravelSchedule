import SwiftUI

struct RouteCard: View {
    @State var isPresenting: Bool = false
    @EnvironmentObject var vM: StationSelectionVM
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text(vM.fromStation ?? "Откуда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(vM.fromStation == nil ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture { isPresenting = true }
                    .fullScreenCover(isPresented: $isPresenting) {
                        SelectSettlementView()
                    }
                Text(vM.toStation ?? "Куда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(vM.toStation == nil ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture { isPresenting = true }
                    .fullScreenCover(isPresented: $isPresenting) {
                        SelectSettlementView()
                    }
            }
            .background(.ypWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button(action: vM.swapFromTo) {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 36, height: 36)
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.ypBlue)
                }
            }
        }
        .padding(16)
        .background(.ypBlue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    VStack {
        RouteCard()
        .padding()
        .environmentObject(StationSelectionVM())
    }
    
}
