import SwiftUI

struct DestinationCardView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                DestinationCardRowView(text: vM.fromStation?.title, placeholder: "Откуда")
                    .onTapGesture { vM.path.append("SelectSettlementFrom") }
                DestinationCardRowView(text: vM.toStation?.title, placeholder: "Куда")
                    .onTapGesture { vM.path.append("SelectSettlementTo") }
            }
            .background(.white)
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
    }
}

#Preview {
    VStack {
        DestinationCardView()
            .padding()
            .environmentObject(MainVM())
    }
}
