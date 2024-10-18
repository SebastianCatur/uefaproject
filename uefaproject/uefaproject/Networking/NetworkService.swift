//
//  NetworkService.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import Foundation

// simulating real api data request
//protocol NetworkInterface {
//  func getSquad(id: UUID) async throws -> ClubSquad
//}
//
//class NetworkInterfaceImpl: NetworkInterface {
//  func getSquad(id: UUID) async throws -> ClubSquad {
//    guard let squadURL = URL(string: BaseURL.squad.rawValue).apendingPathComponent(id.uuidString) else { return }
//    return networkService.fetchData(url: squadURL)
//  }
//}

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: URL, fileName: String?) async throws -> T
}

enum BaseURL: String {
    case squad = "uefa.com/api/squads/"
}

class NetworkService: NetworkServiceProtocol {
    func fetchData<T>(url: URL, fileName: String?) async throws -> T where T : Decodable {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func fetchData<T: Decodable>(url: URL, fileName: String?) async throws -> T {
        if let error = mockError {
            throw error
        } else if let data = mockData {
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            return decodeData
        } else if let fileName = fileName {
            return try loadMockData(from: fileName)
        } else {
            throw NSError(domain: "No mock data", code: -1, userInfo: nil)
        }
    }
    
    private func loadMockData<T: Decodable>(from fileName: String) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "Mock data file not found", code: -1, userInfo: nil)
        }
        
        let data = try Data(contentsOf: url)
        let decodeData = try JSONDecoder().decode(T.self, from: data)
        return decodeData
    }
}
