//
//  SquadViewViewModel.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import SwiftUI

extension SquadView {
    final class ViewModel: ObservableObject {
        var networkService: NetworkServiceProtocol
        @Published var roles = [Role]()
        
        init(networkService: NetworkServiceProtocol = MockNetworkService(), roles: [Role] = [Role]()) {
            self.networkService = networkService
            self.roles = roles
            fetchData(fileName: "Squad")
        }
        
        func fetchData(fileName: String?) {
            guard let url = URL(string: BaseURL.squad.rawValue) else {
                print("url:\(BaseURL.squad.rawValue) couldn't be constructed")
                return
            }
            
            Task {
                do {
                    let data: ClubSquad = try await networkService.fetchData(url: url, fileName: fileName)
                    DispatchQueue.main.async {
                        self.roles = data.roles
                    }
                } catch {
                    DispatchQueue.main.async {
                        let error = error
                        print("error: \(error)")
                    }
                }
            }
        }
    }
}
