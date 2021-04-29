//
//  DateHelper.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import Foundation


extension Date {
    
    func stringValue() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            return formatter.string(from: self)
        }
    
}//End of extension

