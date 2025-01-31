import SwiftUI

// Перемещение по экранам
@MainActor
final class NavigationVM: ObservableObject {
    @Published var path: [String] = []
}
