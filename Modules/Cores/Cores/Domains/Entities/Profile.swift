//
//  Profile.swift
//  Cores
//
//  Created by Muhammad Fachri Nuriza on 13/10/23.
//

import Foundation

public struct Profile: Codable {
    public var email: String
    public var name: String
    public var origin: String
    
    public init(email: String, name: String, origin: String) {
        self.email = email
        self.name = name
        self.origin = origin
    }
}
