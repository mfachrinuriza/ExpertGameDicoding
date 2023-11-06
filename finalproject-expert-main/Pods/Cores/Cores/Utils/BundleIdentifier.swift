//
//  CoreBundle.swift
//  Cores
//
//  Created by Muhammad Fachri Nuriza on 30/10/23.
//

import Foundation

public class CoreBundle {
    public static func getIdentifier() -> String {
        let bundle = Bundle(for: CoreClass.self)
        let bundleId = bundle.bundleIdentifier ?? ""
        return bundleId
    }
}
