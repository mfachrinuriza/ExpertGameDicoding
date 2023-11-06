//
//  Colors.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit

public enum ColorEnum {
    case bg
    case black10
    case black20
    case black40
    case black70
    case primary
}

public class Color: NSObject {
    public class func getColor(name: ColorEnum) -> UIColor? {
        switch name {
        case .bg:
            return UIColor(named: "Bg", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black10:
            return UIColor(named: "Black10", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black20:
            return UIColor(named: "Black20", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black40:
            return UIColor(named: "Black40", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black70:
            return UIColor(named: "Black70", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .primary:
            return UIColor(named: "Primary", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
            
        }
    }
}
