//
//  RouterProtocol.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 29/08/23.
//

import UIKit

public protocol RouterProtocol {
    var initialRoute: Route { get }
    
    associatedtype V: UIViewController
    
    func getView(for route: Route) -> V
}
