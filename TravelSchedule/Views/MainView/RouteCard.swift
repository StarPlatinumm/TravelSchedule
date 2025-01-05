import SwiftUI

struct RouteCard: View {
    @State var from: String?
    @State var to: String?
    
    let defaultFrom: String? = nil
    let defaultTo: String? = nil
    
    func swapFromTo() { (from, to) = (to, from) }
    
    var body: some View {
        HStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text(from ?? "Откуда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(from == defaultFrom ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(to ?? "Куда")
                    .lineLimit(1)
                    .padding(14)
                    .foregroundColor(to == defaultTo ? .ypGray : .ypBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(.ypWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button(action: swapFromTo) {
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
        RouteCard(
            to: "Санкт-Петербург (Балтийский вокзал)"
        )
        .padding()
    }
    
}
