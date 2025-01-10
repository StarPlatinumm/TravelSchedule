import SwiftUI

struct CarrierInfoView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 28) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    Spacer()
                }
                
                Text("ОАО \"РЖД\"")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                    Text("info@rzhd.ru")
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Телефон")
                    Text("+7 (904) 329-27-71")
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
