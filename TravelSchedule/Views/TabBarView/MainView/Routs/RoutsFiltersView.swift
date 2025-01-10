import SwiftUI

enum DepartureTime: String {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

struct RoutsFiltersView: View {
    @EnvironmentObject private var vM: MainVM
    @State private var departureTimeSelected: [DepartureTime] = []
    @State private var allowTransfers: Bool?
    
    var body: some View {
        ZStack {
            Color.ypWhite.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    CheckboxField(departureTime: .morning, departureTimeSelected: $departureTimeSelected)
                    CheckboxField(departureTime: .afternoon, departureTimeSelected: $departureTimeSelected)
                    CheckboxField(departureTime: .evening, departureTimeSelected: $departureTimeSelected)
                    CheckboxField(departureTime: .night, departureTimeSelected: $departureTimeSelected)
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(spacing: 0) {
                    RadioButtonField(value: true, allowTransfers: $allowTransfers)
                    RadioButtonField(value: false, allowTransfers: $allowTransfers)
                }
                Spacer()
                Button(action: {
                    vM.path.removeLast()
                }) {
                    HStack {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.ypRed)
                    }
                }
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

struct CheckboxField: View {
    var departureTime: DepartureTime
    @Binding var departureTimeSelected: [DepartureTime]
    
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

struct RadioButtonField: View {
    var value: Bool
    @Binding var allowTransfers: Bool?
    
    var body: some View {
        HStack {
            Text(value ? "Да" : "Нет")
            Spacer()
            Button(action: {
                self.allowTransfers = value
            }) {
                Image(systemName: allowTransfers == value ? "largecircle.fill.circle" : "circle")
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    RoutsFiltersView()
        .environmentObject(MainVM())
}
