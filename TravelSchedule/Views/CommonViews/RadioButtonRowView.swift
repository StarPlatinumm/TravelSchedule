import SwiftUI

struct RadioButtonRowView: View {
    @Binding var transfersAllowed: Bool
    let value: Bool
    
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
