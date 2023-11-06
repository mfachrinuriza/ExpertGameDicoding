//
//  CoreAssembly.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/10/23.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Cores
import CoreData

class CoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Navigator.self) { _ in
            Navigator(router: Router())
        }.inObjectScope(.container)
        
        container.register(NSManagedObjectContext.self) { _ in
            Helper.getManageContext()
        }.inObjectScope(.container)
        
        container.autoregister(MainViewController.self, initializer: MainViewController.init)

    }
}
