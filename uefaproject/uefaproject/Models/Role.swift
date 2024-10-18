//
//  Role.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import Foundation

struct Role: Identifiable, Codable {
    public let id = UUID()
    public var name: String
    public var players: [Player]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case players
    }
}
