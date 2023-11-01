//
//  Game.swift
//  Cores
//
//  Created by Muhammad Fachri Nuriza on 10/10/23.
//

import Foundation

public struct Game: Codable {
    public var id: Int?
    public var slug: String?
    public var name: String?
    public var released: String?
    public var description: String?
    public var background_image: String?
    public var rating: Double?
    
    public init(id: Int? = nil, slug: String? = nil, name: String? = nil, released: String? = nil, description: String? = nil, background_image: String? = nil, rating: Double? = nil) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.description = description
        self.background_image = background_image
        self.rating = rating
    }
}

extension Game {
    public init(from gameData: GameData) {
        self.init(
            id: gameData.id,
            slug: gameData.slug,
            name: gameData.name,
            released: gameData.released,
            description: gameData.description,
            background_image: gameData.background_image,
            rating: gameData.rating
        )
    }
}
