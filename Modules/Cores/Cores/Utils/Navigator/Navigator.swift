//
//  Navigator.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 29/08/23.
//

import UIKit

public final class Navigator: ObservableObject {
    public let navigationController: UINavigationController = UINavigationController()
    public let router: any RouterProtocol
    
    public init(router: any RouterProtocol) {
        self.router = router
    }
    
    public func start() {
        self.push(router.initialRoute, animated: false)
    }
    
    public func push(_ route: Route, animated: Bool = true) {
        let viewController = self.getViewController(for: route)
        self.navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func presentSheet(_ route: Route, animated: Bool = true) {
        let viewController = self.getViewController(for: route)
        viewController.modalPresentationStyle = .formSheet
        self.navigationController.present(viewController, animated: animated)
    }
    
    public func presentFullscreen(_ route: Route, animated: Bool = true) {
        let viewController = self.getViewController(for: route)
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(viewController, animated: animated)
    }
    
    public func pop(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        self.navigationController.popToRootViewController(animated: animated)
    }
    
    public func dismiss(animated: Bool = true) {
        self.navigationController.dismiss(animated: animated)
    }
    
    private func getViewController(for route: Route) -> UIViewController {
        let viewController = router.getView(for: route)        
        return viewController
    }
}

