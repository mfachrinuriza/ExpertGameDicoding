//
//  Router.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/10/23.
//

import UIKit
import Cores

struct Router: RouterProtocol {
    
    static let shared = Router()
    
    let initialRoute: Route = .main
    
    func getView(for route: Route) -> UIViewController {
        switch route {
        case .main:
            let mainViewController = DI.get(MainViewController.self)
            return mainViewController
        case .home:
            let homeViewController = DI.get(HomeViewController.self)
            return homeViewController
        case .favorite:
            let favoriteViewController = DI.get(FavoriteViewController.self)
            return favoriteViewController
        case .detail(let gameId):
            let detailViewController = DI.get(DetailViewController.self)
            detailViewController.gameId = gameId
            return detailViewController
        case .profile:
            let profileViewController = DI.get(ProfileViewController.self)
            return profileViewController
        case .profileEdit(let profile):
            let profileEditViewController = DI.get(ProfileEditViewController.self)
            profileEditViewController.profileData = profile
            return profileEditViewController
        case .search(let gameList):
            let searchViewController = DI.get(SearchViewController.self)
            searchViewController.gameList = gameList
            return searchViewController
        }
    }
}
