import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

enum ErrorType: Error {
    case noInternet
    case serverError
}

protocol DataProviderProtocol {
    func getSearch(from: String, to: String, date: String, transfers: Bool) async throws -> Components.Schemas.SearchResults
    func getStationsList() async throws -> Components.Schemas.StationsList
}

extension Components.Schemas.Station: Identifiable {
    var id: UUID { UUID() }
}

extension Components.Schemas.Settlement: Identifiable {
    var id: UUID { UUID() }
}

extension Components.Schemas.Segment: Identifiable {
    var id: UUID { UUID() }
}

final class DataProvider: DataProviderProtocol {
    private let client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
    private let apikey = "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
    
    func getSearch(from: String, to: String, date: String, transfers: Bool = true) async throws -> Components.Schemas.SearchResults {
        do {
            let response = try await client.getSearch(query: .init(
                apikey: apikey,
                from: from,
                to: to,
                date: date,
                transfers: transfers
            ))

            return try response.ok.body.json
        } catch {
            print("Error: \(error)")
            throw ErrorType.serverError
        }
    }
    
    func getStationsList() async throws -> Components.Schemas.StationsList {
        do {
            let response = try await client.getStationsList(query: .init(
                apikey: apikey
            ))
            
            let limit = 1024 * 1024 * 60 // 60MiB
            let body = try response.ok.body.html
            let data = try await Data(collecting: body, upTo: limit)
            let list = try JSONDecoder().decode(Components.Schemas.StationsList.self, from: data)
            return list
        } catch {
            print("Error: \(error)")
            throw ErrorType.serverError
        }
    }
}
