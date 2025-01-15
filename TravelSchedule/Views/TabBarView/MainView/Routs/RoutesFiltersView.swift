import SwiftUI

struct RoutesFiltersView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    CheckboxRowView(departureTimeSelected: $vM.departureTimeSelected, departureTime: .morning)
                    CheckboxRowView(departureTimeSelected: $vM.departureTimeSelected, departureTime: .afternoon)
                    CheckboxRowView(departureTimeSelected: $vM.departureTimeSelected, departureTime: .evening)
                    CheckboxRowView(departureTimeSelected: $vM.departureTimeSelected, departureTime: .night)
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    RadioButtonRowView(transfersAllowed: $vM.transfersAllowed, value: true)
                    RadioButtonRowView(transfersAllowed: $vM.transfersAllowed, value: false)
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
