//
//  babtBirthChooser_ViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/21.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class babtBirthChooser_ViewController: UIViewController,UIPopoverPresentationControllerDelegate,UIPopoverControllerDelegate {
    
    weak var delegate : addBaby_ViewController?
    var dateStr = ""
    var date  = 0
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func okBtn(_ sender: UIButton) {
        delegate?.birthInpute.text = dateStr
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func birthChoose(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        dateStr = formatter.string(from: sender.date)
//        if let date = Int(dateStr){
//               print(date)
//        }
     
        print(dateStr)
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
