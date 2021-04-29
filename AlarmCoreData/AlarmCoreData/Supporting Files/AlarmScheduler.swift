//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import UserNotifications


//MARK: - Protocol
protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
} //End of protocol


//MARK: - Extension
extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        guard let alarmTime = alarm.fireDate,
              let identifier = alarm.uuidString else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Your alarm is going off"
        content.sound = .default
        
        let alarmComponents = Calendar.current.dateComponents([.hour, .minute], from: alarmTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: alarmComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let _ = error {
                print("Unable to add notification request")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        guard let identifier = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }

}//End of extension
