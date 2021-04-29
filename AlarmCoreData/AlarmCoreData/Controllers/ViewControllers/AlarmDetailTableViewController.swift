//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Mike Conner on 4/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    
    //MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        } else {
            isAlarmOn.toggle()
        }
        designIsEnabledButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        } else {
            AlarmController.shared.createAlarm(withTitle: title, and: alarmFireDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Functions
    func updateView() {
        if let alarm = alarm {
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
        } else {
            alarmIsEnabledButton.isEnabled = false
            designIsEnabledButton()
        }
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .white
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }
    
} //End of class
