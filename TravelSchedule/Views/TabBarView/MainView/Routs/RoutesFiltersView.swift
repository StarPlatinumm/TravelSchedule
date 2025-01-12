import SwiftUI

struct RoutesFiltersView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    CheckboxRowView(departureTime: .morning, departureTimeSelected: $vM.departureTimeSelected)
                    CheckboxRowView(departureTime: .afternoon, departureTimeSelected: $vM.departureTimeSelected)
                    CheckboxRowView(departureTime: .evening, departureTimeSelected: $vM.departureTimeSelected)
                    CheckboxRowView(departureTime: .night, departureTimeSelected: $vM.departureTimeSelected)
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    RadioButtonRowView(value: true, transfersAllowed: $vM.transfersAllowed)
                    RadioButtonRowView(value: false, transfersAllowed: $vM.transfersAllowed)
                }
                Spacer()
                Button("Применить", action: {
                    vM.filterRoutes()
                    vM.path.removeLast()
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
    RoutesFiltersView()
        .environmentObject(MainVM())
}
