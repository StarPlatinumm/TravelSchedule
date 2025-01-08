import SwiftUI

struct RoutsListView: View {
    @EnvironmentObject private var vM: MainVM
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    RoutsListView()
        .environmentObject(MainVM())
}
