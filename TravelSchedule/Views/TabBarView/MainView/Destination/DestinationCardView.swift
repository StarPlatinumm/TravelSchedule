import SwiftUI

struct DestinationCardView: View {
    @EnvironmentObject private var navigationVM: NavigationVM
    @ObservedObject private var stationsVM: StationsVM
    
    init(stationsVM: StationsVM) {
        self.stationsVM = stationsVM
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                DestinationCardRowView(text: stationsVM.fromStation?.title, placeholder: "Откуда")
                    .onTapGesture {
                        navigationVM.path.append("SelectSettlementFrom")
                    }
                
                DestinationCardRowView(text: stationsVM.toStation?.title, placeholder: "Куда")
                    .onTapGesture {
                        navigationVM.path.append("SelectSettlementTo")
                    }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button(action: stationsVM.swapFromTo) {
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
    }
}

#Preview {
    VStack {
        DestinationCardView(stationsVM: StationsVM())
            .padding()
            .environmentObject(NavigationVM())
    }
}
