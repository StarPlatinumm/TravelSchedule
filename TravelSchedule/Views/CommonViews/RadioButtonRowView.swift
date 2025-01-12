import SwiftUI

struct RadioButtonRowView: View {
    var value: Bool
    @Binding var transfersAllowed: Bool
    
    var body: some View {
        HStack {
            Text(value ? "Да" : "Нет")
            Spacer()
            Button(action: {
                self.transfersAllowed = value
            }) {
                Image(systemName: transfersAllowed == value ? "largecircle.fill.circle" : "circle")
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 60)
    }
}
