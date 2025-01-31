import SwiftUI

struct CarrierInfoView: View {
    private let carrier: Components.Schemas.Carrier
    
    init(carrier: Components.Schemas.Carrier) {
        self.carrier = carrier
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 28) {
                HStack {
                    Spacer()
                    
                    AsyncImage(url: URL(string: carrier.logo ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                    Spacer()
                }
                
                Text(carrier.title ?? "-")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                    
                    Text(carrier.email ?? "-")
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Телефон")
                    
                    Text(carrier.phone ?? "-")
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
    CarrierInfoView(carrier: Components.Schemas.Carrier(title: "ОАО \"РЖД\"", phone: "+7 (987) 654-32-10", logo: "", email: "rzhd@rzhd.ru"))
}
