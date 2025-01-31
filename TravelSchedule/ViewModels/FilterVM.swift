import SwiftUI

// Логика и данные для фильтрации маршрутов
@MainActor
final class FilterVM: ObservableObject {
    @Published var departureTimeSelected: [DepartureTime] = []
    @Published var transfersAllowed: Bool = true
}
