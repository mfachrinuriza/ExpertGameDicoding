//
//  Route.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 29/08/23.
//

import Foundation

public enum Route {
    case main
    case home
    case favorite
    case detail(gameId: Int)
    case profile
    case profileEdit(profile: Profile)
    case search(gameList: [Game])
}
