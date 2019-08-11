//
//  add_ViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/17.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class add_ViewController: UIViewController ,UIPopoverPresentationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate{

    var current : AddList!
    var sid = -1
    var pid2 = 0
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        //使用者輸入存到ＤＢ
        if titleText.text == ""{
            let alert = UIAlertView(title: "錯誤", message: "請輸入標題", delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "確定" )
            alert.show()
        }else{
            current.title = titleText.text!
            self.navigationController?.popViewController(animated: true)
            current.location = locationText.text!
            current.mood = moodLabel.text!
            current.time = timeText.text!
            current.photo = img.image?.pngData()
            current.pid = pid2
        }
        
//        current.location = locationText.text!
//        current.mood = moodLabel.text!
//        current.time = timeText.text!
//        current.photo = img.image?.pngData()
//        current.pid = pid2
        if sid == -1{
            AddListDAO.insert(data: current)
        }else{
            AddListDAO.update(data: current)
        }
//        self.navigationController?.popViewController(animated: true)
//        print(current.title)
        
        
        
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet var timeText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var moodLabel: UITextView!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBAction func seqGenderChoose(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let imgVC = UIImagePickerController()
            imgVC.sourceType = .camera
            imgVC.delegate = self
            present(imgVC,animated: true,completion: nil)
        }else{
            let imgVC = UIImagePickerController()
            imgVC.sourceType = .photoLibrary
            imgVC.delegate = self
            present(imgVC,animated: true,completion: nil)
        }
    }
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgL = info[.originalImage] as! UIImage
        img.image = imgL
        UIImageWriteToSavedPhotosAlbum(imgL, nil, nil, nil)
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func viewPop(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sid == -1 {
            self.title = "新增"
            current = AddList()
            let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                let today = formatter.string(from: Date())
                timeText.text = today
        }else{
            self.title = "編輯"
            current = AddListDAO.getBabyInfoBySid(sid: sid)
            titleText.text = current.title
            timeText.text = current.time
            locationText.text = current.location
            moodLabel.text = current.mood
            if let photo = current.photo{
                img.image = UIImage(data: photo)
            }
        }
        
        
        
        
        //隱藏tab bar
//        self.tabBarController?.hidesBottomBarWhenPushed = true
//        self.tabBarController?.tabBar.isHidden = true
       // self.automaticallyAdjustsScrollViewInsets = false
        //鍵盤
//        titleText.becomeFirstResponder()
//        timeText.becomeFirstResponder()
//        moodLabel.becomeFirstResponder()
        
        //初始值先顯示當天
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMdd"
//        let today = formatter.string(from: Date())
//        timeText.text = today
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.preferredContentSize = CGSize(width: 300, height: 300)
        if segue.identifier == "segue_showPop"{
            segue.destination.popoverPresentationController?.delegate = self //as? UIPopoverPresentationControllerDelegate
            
            //timepicker收值
            if let next = segue.destination as? timePicker_ViewController {
                next.fromtimePickerdelegate = self
            }
        }
    }
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 1) {
            self.view.frame.origin.y = -150
        }
        return false
    }
    //鍵點擊螢幕會跳退出鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
}
    

