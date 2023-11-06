//
//  Helper.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import UIKit
import CoreData

class Helper {
    static func getManageContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
