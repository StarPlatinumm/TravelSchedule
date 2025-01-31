import SwiftUI

struct RouteCardView: View {
    private let route: Components.Schemas.Segment
    private let departure: String
    private let arrival: String
    private let startDate: String
    private let duration: String
    
    init(route: Components.Schemas.Segment) {
        self.route = route
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let shortDateFormatter = DateFormatter()
        shortDateFormatter.dateFormat = "dd MMMM"
        shortDateFormatter.locale = Locale(identifier: "ru_RU")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let dateAndTimeFormatter = DateFormatter()
        dateAndTimeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        departure = timeFormatter.string(from: dateAndTimeFormatter.date(from: route.departure ?? "") ?? Date())
        arrival = timeFormatter.string(from: dateAndTimeFormatter.date(from: route.arrival ?? "") ?? Date())
        startDate = shortDateFormatter.string(from: dateFormatter.date(from: route.start_date ?? "") ?? Date())
        duration = "\((route.duration ?? 0) / 3600) часов"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 18) {
                HStack(spacing: 8) {
                    AsyncImage(url: URL(string: route.thread?.carrier?.logo ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading) {
                        Text(route.thread?.carrier?.title ?? "-")
                            .font(.system(size: 17))
                        if route.has_transfers ?? false {
                            Text("Есть пересадка")
                                .font(.system(size: 12))
                                .foregroundColor(.ypRed)
                        }
                    }
                    
                    Spacer()
                    
                    Text(startDate)
                        .font(.system(size: 12))
                }
                HStack {
                    Text(departure)
                    
                    Rectangle()
                        .foregroundColor(.ypGray)
                        .background(.ypGray)
                        .frame(height: 1)
                    
                    Text(duration)
                        .font(.system(size: 12))
                    
                    Rectangle()
                        .foregroundColor(.ypGray)
                        .background(.ypGray)
                        .frame(height: 1)
                    
                    Text(arrival)
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
