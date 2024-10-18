//
//  ClubScreenViewModel.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import Foundation
import SwiftUI

extension ClubScreenView {
    final class ViewModel: ObservableObject {
        var networkService: NetworkServiceProtocol
        @Published var squadName = "Barca"
        @Published var roundNumber = 1
        @Published var squadCrest = UIImage(named: "crestImage") ?? UIImage()
        var urlString = BaseURL.squad.rawValue
        
        init(networkService: NetworkServiceProtocol = MockNetworkService(), squadCrest: UIImage = UIImage(named: "crestImage") ?? UIImage()) {
            self.networkService = networkService
            self.squadCrest = squadCrest
            
            fetchData(fileName: "Squad")
        }
        
        func fetchData(fileName: String) {
            // should be used id instead of baseurl
            guard let url = URL(string: urlString) else {
                print("url:\(BaseURL.squad.rawValue) couldn't be constructed")
                return
            }
            
            Task {
                do {
                    let data: ClubSquad = try await networkService.fetchData(url: url, fileName: fileName)
                    DispatchQueue.main.async {
                        self.squadName = data.squadName
                        self.roundNumber = data.roundNumber
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.squadName = "Barca"
                        self.roundNumber = 1
                        let error = error
                        print("error: \(error)")
                    }
                }
            }
        }
        
    }
}
