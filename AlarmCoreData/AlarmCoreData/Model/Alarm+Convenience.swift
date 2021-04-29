//
//  Alarm+Convenience.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import CoreData

extension Alarm {
    
    @discardableResult convenience init(title: String, isEnabled: Bool = true, fireDate: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.isEnabled = isEnabled
        self.fireDate = fireDate
        self.uuidString = UUID().uuidString
    }
    
}//End of extension
