//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}


class AlarmTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var alarmTitleCell: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    weak var delegate: AlarmTableViewCellDelegate?
    var alarm: Alarm?
    
    
    //MARK: - Actions
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
    }
    
    //MARK: - Functions
    func updateViews(for alarm: Alarm) {
        alarmTitleCell.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.stringValue()
        isEnabledSwitch.isOn = alarm.isEnabled
    }
    
} //End of class
