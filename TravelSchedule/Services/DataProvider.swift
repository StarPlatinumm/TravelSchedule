import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias NearestStations = Components.Schemas.Stations
typealias NearestSettlement = Components.Schemas.Settlement
typealias Carrier = Components.Schemas.Settlement

protocol DataProviderProtocol {
    func getThread(uid: String, from: String?, to: String?, show_systems: String?) async throws -> Components.Schemas.Thread
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Stations
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Settlement
    func getCarrierInfo(code: String, system: String) async throws -> Components.Schemas.Carriers
    func getStationsList() async throws
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright
}

final class DataProvider: DataProviderProtocol {
    private let client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
    private let apikey = "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
    
    func getThread(uid: String, from: String?, to: String?, show_systems: String?) async throws -> Components.Schemas.Thread {
        let response = try await client.getThread(query: .init(
            apikey: apikey,
            uid: uid,
            from: from,
            to: to,
            show_systems: show_systems
        ))
        return try response.ok.body.json
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
    
    func getStationsList() async throws {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        
        print(response)
    }
    
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
