//
//  addBaby_ViewController.swift
//  My Day
//
//  Created by bolin on 2019/7/18.
//  Copyright © 2019 bolin. All rights reserved.
//

import UIKit

class addBaby_ViewController: UIViewController,UIPopoverPresentationControllerDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //data
    var sid = -1
    var current : AddBaby!
    
    @IBAction func photoChoose(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            let imgVc = UIImagePickerController()
            imgVc.sourceType = .camera
            imgVc.delegate = self
            present(imgVc,animated: true,completion: nil)
        }else{
            let imgVC = UIImagePickerController()
            imgVC.sourceType = .photoLibrary
            imgVC.modalTransitionStyle = .flipHorizontal
            imgVC.delegate = self
            present(imgVC,animated: true,completion: nil)
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as! UIImage
        photoInpute.image = img
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func seqGender(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            current.gender = "男寶寶"
        }else{
            current.gender = "女寶寶"
        }
        print(sender.selectedSegmentIndex)
    }
    
    @IBAction func saveHandler(_ sender: UIButton) {
        //收集使用者輸入
        if  babyNameInpute.text  == ""{
            let alert = UIAlertView(title: "錯誤", message: "請輸入姓名", delegate: self, cancelButtonTitle: "確定")
            alert.show()
        }else if birthInpute!.text == ""{
            let alert = UIAlertView(title: "錯誤", message: "請輸入生日", delegate: self, cancelButtonTitle: "確定")
            alert.show()
        }else{
            current.birth = birthInpute.text!
            current.name = babyNameInpute.text!
            current.photo = photoInpute.image?.pngData()
            dismiss(animated: true, completion: nil)
        }
//        current.birth = birthInpute.text!
//        current.name = babyNameInpute.text!
//        current.photo = photoInpute.image?.pngData()
        
        //新增或修改
        if sid == -1{
            AddBabyDAO.insert(data: current)
        }else{
            AddBabyDAO.update(data: current)
        }
        
//        dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var birthInpute: UITextField!
    @IBAction func dateChooser(_ sender: UIButton) {
        
    }
   
    
    @IBOutlet weak var photoInpute: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var babyNameInpute: UITextField!
    @IBAction func backHandler1(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func backHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   print("AddBaby\(current)")
        
        if sid == -1{
            titleLabel.text = "新增"
            current = AddBaby()
        }else{
            titleLabel.text = "修改"
            current = AddBabyDAO.getBabyInfoBySid(sid: sid)
            babyNameInpute.text = current.name
//            babyBirthInpute.text = current.birth
            if let photo = current.photo{
                photoInpute.image = UIImage(data: photo)
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.preferredContentSize = CGSize(width: 400, height: 400) // 跳出的大小
        if segue.identifier == "show"{
            segue.destination.popoverPresentationController?.delegate = self
        }//連接日期選擇器
        if let next = segue.destination as? babtBirthChooser_ViewController{
            next.delegate = self
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none //日期選擇器跳出的樣式
    }
}
