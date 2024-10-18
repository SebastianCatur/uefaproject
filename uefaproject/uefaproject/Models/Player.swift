//
//  Player.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import Foundation

struct Player: Codable, Identifiable {
    let id = UUID()
    public let playerName: String
    public let country: String
    public let points: Int
    public let playerRole: String
    public let playerImage: String
    
    private enum CodingKeys: String, CodingKey {
        case playerName
        case country
        case points
        case playerRole
        case playerImage
    }
}
