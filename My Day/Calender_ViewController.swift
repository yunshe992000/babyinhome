//
//  Calender_ViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/25.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class Calender_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var currentTimeInpute :String!
    var list = [AddList]()
    var today = ""
    var sid = 0
    var newday = ""
    
    override func viewWillAppear(_ animated: Bool) {
        list = AddListDAO.getAllBabyInfoByTime(time: newday)
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func viewDidAppear(_ animated: Bool) {
        list = AddListDAO.getAllBabyInfoByTime(time: newday)
        //print(list)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let data = list[indexPath.row]
        cell.textLabel?.text = data.title
        cell.detailTextLabel!.text = data.time
        if let po = data.photo{
            cell.imageView?.image = UIImage(data: po)
            print("datatime : \(data.time)")
        }
        return cell
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIView!
    @IBAction func timeBtn(_ sender: UIButton) {
        pickerView.isHidden = false
    }
    @IBAction func cancelBtn(_ sender: UIButton) {
        
        pickerView.isHidden = true
    }
    @IBAction func okBtn(_ sender: Any) {
        dateLabel.text = currentTimeInpute
        print("currentTimeInpute : \(currentTimeInpute)")
        pickerView.isHidden = true
        list = AddListDAO.getAllBabyInfoByTime(time: newday)
        tableView.reloadData()
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 MM月 dd日"
        currentTimeInpute = formatter.string(from: sender.date)
        let today = formatter.string(from: Date())
        //撈DB時間格式
        let newformatter = DateFormatter()
        newformatter.dateFormat = "yyyyMMdd"
        newday = newformatter.string(from: sender.date)
        print("newday:\(newday)")
        print(list)
    }
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示當天日期
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 MM月 dd日"
        today = formatter.string(from: Date())
        dateLabel.text = today
        
        let newformatter = DateFormatter()
        newformatter.dateFormat = "yyyyMMdd"
        newday = newformatter.string(from: Date())
//        formatter.dateFormat = "yyyyMMdd"
//        newday = formatter.string(from: Date())
//        print("today : \(newday)")
//        list = AddListDAO.getAllBabyInfoByTime(time: newday)
        //print(list)
        tableView.reloadData()

    }

    
    
    
    
    
}
