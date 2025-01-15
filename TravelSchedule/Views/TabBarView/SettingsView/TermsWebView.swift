import SwiftUI
import WebKit

struct TermsWebView: View {
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea(.all)
            
            TermsWebViewContent()
                .edgesIgnoringSafeArea(.bottom)
                .navigationTitle("Пользовательское соглашение")
        }
    }
}

struct TermsWebViewContent: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: "https://yandex.ru/legal/practicum_offer") {
            webView.load(URLRequest(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    TermsWebView()
}
