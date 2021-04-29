//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import CoreData

class AlarmController: AlarmScheduler {
    
    //MARK: - Properties
    static let shared = AlarmController()
    var alarms: [Alarm] = []
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private init() {}
    
    //MARK: - Functions
    func fetch() {
        alarms = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
    }
    
    //MARK: - CRUD Functions
    func createAlarm(withTitle title: String, and fireDate: Date) {
        let alarm = Alarm(title: title, fireDate: fireDate)
        alarms.append(alarm)
        savetoPersistentStore()
        scheduleUserNotifications(for: alarm)
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        cancelUserNotifications(for: alarm)
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        savetoPersistentStore()
        scheduleUserNotifications(for: alarm)
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        savetoPersistentStore()
        alarm.isEnabled ? scheduleUserNotifications(for: alarm) : cancelUserNotifications(for: alarm)
        
    }
    
    func delete(alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
        cancelUserNotifications(for: alarm)
        CoreDataStack.context.delete(alarm)
        savetoPersistentStore()
    }
    
    func savetoPersistentStore() {
        CoreDataStack.saveContext()
    }
    
} //End of class
