//
//  MainViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import Cores

class MainViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let home = Router.shared.getView(for: .home)
        home.title = "Home"
        
        let favorite = Router.shared.getView(for: .favorite)
        favorite.title = "Favorite"
        
        let profile = Router.shared.getView(for: .profile)
        profile.title = "Profile"
        
        self.setViewControllers([home, favorite, profile], animated: false)
        
        if let items = self.tabBar.items {
            let images = ["ic_home_gray", "ic_love_gray", "ic_profile_gray"]
            let selections = ["ic_home_black", "ic_love_black", "ic_profile_black"]
            
            for index in 0...(items.count-1) {
                items[index].image = UIImage(named: images[index], in: Bundle(for: CoreClass.self), compatibleWith: nil)!.withRenderingMode(.alwaysOriginal)
                items[index].selectedImage = UIImage(named: selections[index], in: Bundle(for: CoreClass.self), compatibleWith: nil)!.withRenderingMode(.alwaysOriginal)
            }
        }
        
        self.tabBar.tintColor = Color.getColor(name: .black70)
        self.tabBar.barTintColor = Color.getColor(name: .black70)
        self.tabBar.layer.shadowColor = UIColor.white.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 2,height: 5)
        self.tabBar.layer.shadowRadius = 20
        self.tabBar.layer.shadowOpacity = 0.3
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = Color.getColor(name: .bg)
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
}
