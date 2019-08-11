//
//  AddBabyDAO.swift
//  My Day
//
//  Created by bolin on 2019/7/19.
//  Copyright © 2019 bolin. All rights reserved.
//

import Foundation

class AddBabyDAO{
    static var dbPath:String{
        let target = "\(NSHomeDirectory())/Documents/db.sqlite"
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: target){
            if let source = Bundle.main.path(forResource: "MyDay", ofType: "sqlite") {
                try? fileMgr.copyItem(atPath: source, toPath: target)
                
            }
        }
        return target
    }
    static func getBabyInfoBySid(sid:Int)->AddBaby?{
        var data : AddBaby?
        let db = FMDatabase(path:dbPath)
        db?.open()
        if let results = db?.executeQuery("SELECT * FROM AddBabys WHERE sid = ?", withArgumentsIn: [sid]){
            if results.next(){
                //資料庫的sid帶入命名變數
                let sid = results.int(forColumn: "sid")
                let name = results.string(forColumn: "name")
                let birth = results.string(forColumn: "birth")
                let gender = results.string(forColumn: "gender")
                let photo = results.data(forColumn: "photo")
                data = AddBaby(sid: Int(sid),name: name!, birth: birth!, gender: gender!, photo: photo)
            }
        }
        db?.close()
        return data
    }


    static func getAllBabyInfo()->[AddBaby]{
        var list = [AddBaby]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let results = db?.executeQuery("SELECT * FROM AddBabys", withArgumentsIn: []){
            while results.next(){
                let sid = results.int(forColumn: "sid")
                let name = results.string(forColumn: "name")
                let birth = results.string(forColumn: "birth")
                let gender = results.string(forColumn: "gender")
                let photo = results.data(forColumn: "photo")
                let data = AddBaby(sid: Int(sid), name: name!, birth: birth!, gender: gender!, photo: photo)
                list.append(data)
            }
            results.close()
        }
        db?.close()
        return list
    }
    static func execUpdate(_ sql:String,data:[String:Any]){
        execUpdate(sql, data: data, path: dbPath)
    }
    
    static func execUpdate(_ sql:String,data:[String:Any],path:String){
        let db = FMDatabase(path: path)
        db?.open()
        db?.executeUpdate(sql, withParameterDictionary: data)
        db?.close()
    }

    
    static func insert(data:AddBaby){
        var dict = [String:Any]()
        dict["n"] = data.name
        dict["b"] = data.birth
        dict["g"] = data.gender
        dict["p"] = data.photo
        let sql = "INSERT INTO AddBabys(name,birth,gender,photo) VALUES(:n,:b,:g,:p)"
        execUpdate(sql,data: dict)
        
    }

    static func delete(sid:Int){
        var dict = [String:Any]()
        dict["sid"] = sid
        let sql = "DELETE FROM AddBabys WHERE sid = :sid"
        execUpdate(sql, data: dict)
    }

    static func update(data:AddBaby){
        var dict = [String:Any]()
        dict["n"] = data.name
        dict["b"] = data.birth
        dict["g"] = data.gender
        dict["p"] = data.photo
        let sql = "UPDATE AddBabys SET VALUES (name=:n,birth=:b,gender=:g,photo=:p) "
        execUpdate(sql,data: dict)
        
    }
    

}


