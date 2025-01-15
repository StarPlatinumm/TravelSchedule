import SwiftUI

struct CheckboxRowView: View {
    @Binding var departureTimeSelected: [DepartureTime]
    let departureTime: DepartureTime
    
    var body: some View {
        HStack {
            Text(departureTime.rawValue)
            
            Spacer()
            
            Button(action: {
                if !departureTimeSelected.contains(departureTime) {
                    departureTimeSelected.append(departureTime)
                } else {
                    departureTimeSelected = departureTimeSelected.filter { $0 != departureTime }
                }
            }) {
                Image(systemName: departureTimeSelected.contains(departureTime) ? "checkmark.square.fill" : "square")
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 60)
    }
}
