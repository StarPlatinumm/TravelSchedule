import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkThemed") var isDarkThemed: Bool = false
    @State private var isWebViewPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    VStack {
                        HStack {
                            Text("Тёмная тема")
                                .font(.system(size: 17))
                            Spacer()
                            Toggle("", isOn: $isDarkThemed)
                        }
                        .frame(height: 60)
                        
                        NavigationLink(destination: TermsWebView(), isActive: $isWebViewPresented) {
                            EmptyView()
                        }
                        .accentColor(.ypBlack)
                        
                        Button(action: {
                            isWebViewPresented = true
                        }) {
                            HStack {
                                Text("Пользовательское соглашение")
                                    .font(.system(size: 17))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                                    .font(.system(size: 17, weight: .semibold))
                            }
                            .frame(height: 60)
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
}

#Preview {
    SettingsView()
}
