//
//  timeLineDetail_TableViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/14.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit


class timeLineDetail_TableViewController: UITableViewController {
    
    var list = [AddList]()
    var pid = 0
    weak var fromtimePickerdelegate : time_TableViewController!
   // weak var delegate : add_ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
        list = AddListDAO.getAllBabyInfo(pid: pid)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? listCustom_TableViewCell else {
            return UITableViewCell()
        }
        let data = list[indexPath.row]
        cell.listAddress.text = data.location
        cell.listTime.text = data.time
        cell.listTitle.text = data.title
        cell.listMood.text = data.mood
//        cell.listMood.text = String(data.sid)
        if let p = data.photo{
            cell.listImg.image = UIImage(data: p)
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("pid : \(pid)")
        list = AddListDAO.getAllBabyInfo(pid:pid)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            if let next = segue.destination as? add_ViewController{
                next.pid2 = pid
            }
        }
        if segue.identifier == "update"{
            let next = segue.destination as! add_ViewController
            let row = tableView.indexPathForSelectedRow!.row
            let data = list[row]
            next.sid = data.sid
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let data = list.remove(at: indexPath.row)
            let sid = data.sid
            AddListDAO.delete(sid: sid)
            tableView.deleteRows(at: [indexPath], with:.fade)
        }else if editingStyle == .insert{
            
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
}
