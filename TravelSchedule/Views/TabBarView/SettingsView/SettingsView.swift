import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkThemed") private var isDarkThemed: Bool = false
    @EnvironmentObject private var pathData: PathData
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                VStack {
                    Toggle("Тёмная тема", isOn: $isDarkThemed)
                        .frame(height: 60)
                    
                    ChevronRowView(text: "Пользовательское соглашение")
                        .frame(height: 60)
                        .onTapGesture {
                            pathData.path.append("TermsWebView")
                        }
                }
                
                Spacer()
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12))
                Text("Версия 1.0 (beta)")
                    .font(.system(size: 12))
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(PathData())
        .environmentObject(StationSelectionVM())
}
