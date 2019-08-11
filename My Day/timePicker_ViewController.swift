//
//  timePicker_ViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/17.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class timePicker_ViewController: UIViewController,UIPopoverControllerDelegate,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var datePickerView: UIView!
    
    weak var fromtimePickerdelegate : add_ViewController!
    
    
    //Data
    var sid = -1
    var current : TimePicker!
    var timeInpute : String!
    
    @IBAction func dateChooseHandler(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd" //ex: 2016/10/26
        timeInpute = formatter.string(from: sender.date)
        print(timeInpute)
        
//        timeChoose.text = formatter.string(from: sender.date)
//         datePickerView.isHidden = false
    
    }
    @IBAction func okBtn(_ sender: UIButton) {
        fromtimePickerdelegate?.timeText.text = timeInpute
       // fromtimePickerdelegate.time.text = timeInpute
        //datePickerView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var timeChoose: UILabel!
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//       self.timeChoose.text = dateToString(sender: Date())
        
    }
}
