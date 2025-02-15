import SwiftUI

struct ErrorView: View {
    private let errorText: String
    private let errorImageName: String
    
    init(errorType: ErrorType) {
        switch errorType {
        case .noInternet:
            errorText = "Нет интернета"
            errorImageName = "no-internet"
        case .serverError:
            errorText = "Ошибка сервера"
            errorImageName = "server-error"
        }
    }
    
    var body: some View {
        VStack (spacing: 16) {
            Image(errorImageName)
            
            Text(errorText)
                .font(.system(size: 24, weight: .bold))
        }
    }
}

#Preview {
    ErrorView(errorType: .noInternet)
    ErrorView(errorType: .serverError)
}
