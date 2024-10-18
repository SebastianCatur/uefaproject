//
//  ClubSquad.swift
//  uefaproject
//
//  Created by Sebastian Catur on 18.10.2024.
//
import Foundation

struct ClubSquad: Codable {
    let squadName: String
    let squadCrest: String
    var roles: [Role]
    var roundNumber: Int
}
