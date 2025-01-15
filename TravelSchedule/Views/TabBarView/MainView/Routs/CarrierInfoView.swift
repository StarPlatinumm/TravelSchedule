import SwiftUI

struct CarrierInfoView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 28) {
                HStack {
                    Spacer()
                    
                    AsyncImage(url: URL(string: vM.currentCarrier?.logo ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                    Spacer()
                }
                
                Text(vM.currentCarrier?.title ?? "-")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                    
                    Text(vM.currentCarrier?.email ?? "-")
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Телефон")
                    
                    Text(vM.currentCarrier?.phone ?? "-")
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Информация о перевозчике")
        }
    }
}

#Preview {
    CarrierInfoView()
        .environmentObject(MainVM())
}
