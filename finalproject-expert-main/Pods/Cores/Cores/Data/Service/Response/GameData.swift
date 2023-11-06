//
//  GameData.swift
//  Cores
//
//  Created by Muhammad Fachri Nuriza on 10/10/23.
//

import Foundation

public struct GameData: Codable {
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

extension GameData {
    public init(from game: Game) {
        self.init(
            id: game.id,
            slug: game.slug,
            name: game.name,
            released: game.released,
            description: game.description,
            background_image: game.background_image,
            rating: game.rating
        )
    }
}
