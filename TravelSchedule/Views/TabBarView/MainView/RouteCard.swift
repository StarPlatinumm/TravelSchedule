import SwiftUI

struct RouteCard: View {
    @EnvironmentObject private var pathData: PathData
    @EnvironmentObject private var stationSelectionVM: StationSelectionVM
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text(stationSelectionVM.getFullFromStationName() ?? "Откуда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(stationSelectionVM.fromStation == nil ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture { pathData.path.append("SelectSettlementFrom") }
                Text(stationSelectionVM.getFullToStationName() ?? "Куда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(stationSelectionVM.toStation == nil ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture { pathData.path.append("SelectSettlementTo") }
            }
            .background(.ypWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button(action: stationSelectionVM.swapFromTo) {
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
        RouteCard()
        .padding()
        .environmentObject(PathData())
        .environmentObject(StationSelectionVM())
    }
    
}
