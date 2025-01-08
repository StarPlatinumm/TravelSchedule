import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

protocol DataProviderProtocol {
    func getSearch(from: String, to: String, date: String?, show_systems: String?, transport_types: String?, system: String?, offset: Int?, limit: Int?, result_timezone: String?, add_days_mask: Bool?, transfers: Bool?) async throws -> Components.Schemas.SearchSchema
    func getSchedule(station: String, date: String?, transport_types: String?, system: String?, show_systems: String?, result_timezone: String?, event: String?, direction: String?) async throws -> Components.Schemas.ScheduleSchema
    func getThread(uid: String, from: String?, to: String?, date: String?, show_systems: String?) async throws -> Components.Schemas.Thread
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Stations
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Settlement
    func getCarrierInfo(code: String, system: String) async throws -> Components.Schemas.Carriers
    func getStationsList() async throws -> Components.Schemas.StationsList
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright
}

final class DataProvider: DataProviderProtocol {
    private let client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
    private let apikey = "4f5cb8fb-cdbd-4619-8ebf-aedd5c80cc35"
    
    func getSearch(from: String, to: String, date: String? = nil, show_systems: String? = nil, transport_types: String? = nil, system: String? = nil, offset: Int? = nil, limit: Int? = nil, result_timezone: String? = nil, add_days_mask: Bool? = nil, transfers: Bool? = nil) async throws -> Components.Schemas.SearchSchema {
        let response = try await client.getSearch(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date,
            show_systems: show_systems,
            transport_types: transport_types,
            system: system,
            offset: offset,
            limit: limit,
            result_timezone: result_timezone,
            add_days_mask: add_days_mask,
            transfers: transfers
        ))
        return try response.ok.body.json
    }
    
    func getSchedule(station: String, date: String? = nil, transport_types: String? = nil, system: String? = nil, show_systems: String? = nil, result_timezone: String? = nil, event: String? = nil, direction: String? = nil) async throws -> Components.Schemas.ScheduleSchema {
        let response = try await client.getSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: date,
            transport_types: transport_types,
            system: system,
            show_systems: show_systems,
            result_timezone: result_timezone,
            event: event,
            direction: direction
        ))
        return try response.ok.body.json
    }
    
    func getThread(uid: String, from: String? = nil, to: String? = nil, date: String? = nil, show_systems: String? = nil) async throws -> Components.Schemas.Thread {
        let response = try await client.getThread(query: .init(
            apikey: apikey,
            uid: uid,
            from: from,
            to: to,
            date: date,
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
    
    func getStationsList() async throws -> Components.Schemas.StationsList {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        
        let limit = 1024 * 1024 * 50 //50MiB
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: limit)
        let list = try JSONDecoder().decode(Components.Schemas.StationsList.self, from: data)
        return list
    }
    
    func getCopyrightInfo() async throws -> Components.Schemas.Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
