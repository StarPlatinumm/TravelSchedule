import SwiftUI

struct RoutCardView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        HStack(spacing: 16) {
            // вертикальный контейнер
            VStack(spacing: 18) {
                // лого и дата
                HStack(spacing: 8) {
                    AsyncImage(url: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"))
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading) {
                        Text("RZHD")
                            .font(.system(size: 17))
                        Text("Пересадка в Костроме")
                            .font(.system(size: 12))
                            .foregroundColor(.ypRed)
                    }
                    Spacer()
                    Text("14 января")
                        .font(.system(size: 12))
                }
                // время в пути
                HStack {
                    Text("22:30")
                    Rectangle()
                        .foregroundColor(.ypGray)
                        .background(.ypGray)
                        .frame(height: 1)
                    Text("20 часов")
                        .font(.system(size: 12))
                    Rectangle()
                        .foregroundColor(.ypGray)
                        .background(.ypGray)
                        .frame(height: 1)
                    Text("8:15")
                }
            }
        }
        .padding(14)
        .background(.ypLightGray)
        .foregroundColor(.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .listRowBackground(Color.ypWhite)
    }
}

#Preview {
    RoutCardView()
        .environmentObject(MainVM())
}
