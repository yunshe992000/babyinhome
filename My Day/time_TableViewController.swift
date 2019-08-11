//
//  time_TableViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/14.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class time_TableViewController: UITableViewController {
    
    var list = [AddBaby]()
    var sid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDB()
    }
    func testDB(){
        print(AddListDAO.dbPath)
//        print(AddListDAO.getAllBabyInfo().count)
//        
        print(AddBabyDAO.dbPath)
        print("AddBabyDAO.dbPath : \(AddBabyDAO.dbPath)")
//        print(AddBabyDAO.getAllBabyInfo().count)
//        var info = AddBabyDAO.getBabyInfoBySid(sid: 1)
//        var info2 = AddBabyDAO.getBabyInfoBySid(sid: 2)
//        print(info)
//        print(info2)
    
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func viewDidAppear(_ animated: Bool) {
        list = AddBabyDAO.getAllBabyInfo()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? timeLine_TableViewCell else {
            return UITableViewCell()
        }
        let data = list[indexPath.row]
        cell.babyName.text = data.name
        cell.babyBirth.text = data.birth
        cell.babyGender.text = data.gender
//        cell.babyGender.text = String(data.sid)
        //print (String(data.sid))
        //sid = data.sid
        if let po = data.photo{
            cell.imageView?.image = UIImage(data: po)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        print("sid: \(sid)")
        if segue.identifier == "show"{
            let next = segue.destination as? timeLineDetail_TableViewController
            //將第一頁的data.sid值傳給第二頁的pid
           // next?.pid = list[tableView.indexPathForSelectedRow!.row].sid
            
            //傳給下一頁
            next?.pid = list[tableView.indexPathForSelectedRow!.row].sid

          
            
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let data = list.remove(at: indexPath.row)
            let sid = data.sid
            AddBabyDAO.delete(sid: sid)
            tableView.deleteRows(at: [indexPath], with:.fade)
        }else if editingStyle == .insert{

        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    @IBAction func logoutBtn(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                //dismiss(animated: true, completion: nil)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                present(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                present(vc, animated: true, completion: nil)
            }
        }else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
            present(vc, animated: true, completion: nil)
        }
    }
}



