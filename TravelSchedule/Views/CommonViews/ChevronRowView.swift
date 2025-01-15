import SwiftUI

struct ChevronRowView: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            HStack {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .font(.system(size: 17, weight: .semibold))
            }
        }
        .listRowBackground(Color.ypWhite)
    }
}

#Preview {
    ChevronRowView(text: "Test")
        .padding()
}
