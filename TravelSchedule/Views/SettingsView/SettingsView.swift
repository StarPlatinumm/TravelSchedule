import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkThemed") var isDarkThemed: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    VStack {
                        Toggle("Тёмная тема", isOn: $isDarkThemed)
                            .frame(height: 60)
                        
                        NavigationLink(destination: TermsWebView()) {
                            ChevronRowView(text: "Пользовательское соглашение")
                            
                        }
                        .frame(height: 60)
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
}

#Preview {
    SettingsView()
}
