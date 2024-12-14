import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations
typealias NearestSettlement = Components.Schemas.Settlement
typealias Carrier = Components.Schemas.Settlement

protocol DataProviderProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Stations
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Settlement
    func getCarrierInfo(code: String, system: String) async throws -> Components.Schemas.Carriers
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright
}

final class DataProvider: DataProviderProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Stations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Settlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getCarrierInfo(code: String, system: String) async throws -> Components.Schemas.Carriers {
        let response = try await client.getCarriers(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
    
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
