//
//  AddListDAO.swift
//  My Day
//
//  Created by bolin on 2019/7/20.
//  Copyright © 2019 bolin. All rights reserved.
//

import Foundation

class AddListDAO{
    static var dbPath : String{
        let target = "\(NSHomeDirectory())/Documents/dbList.sqlite"
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: target){
            if let source = Bundle.main.path(forResource: "MyDayList", ofType: "sqlite"){
                try? fileMgr.copyItem(atPath: source, toPath: target)
            }
        }
        return target
    }
    static func getBabyInfoBySid(sid:Int)->AddList?{
        var data : AddList?
        let db = FMDatabase(path: dbPath)
        db?.open()
        //        if let results = db?.executeQuery("SELECT * FROM Contacts WHERE sid = \(sid)", withArgumentsIn: []){
        if let results = db?.executeQuery("SELECT * FROM AddList WHERE sid = ?", withArgumentsIn: [sid]){
            if results.next(){
                let sid = results.int(forColumn: "sid")
                let title = results.string(forColumn: "title")
                let time = results.string(forColumn: "time")
                let location = results.string(forColumn: "location")
                let mood = results.string(forColumn: "mood")
                let photo = results.data(forColumn: "photo")
                let pid = results.int(forColumn: "pid")
                data = AddList(sid: Int(sid), title:title! , time: time!, location: location!, mood: mood!, photo: photo!, pid:Int(pid))
            }
        }
        db?.close()
        return data
    }
    //撈所有pid的資料
    static func getAllBabyInfo(pid:Int)->[AddList]{
        var list = [AddList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let results = db?.executeQuery("SELECT * FROM AddList WHERE pid = ? ORDER BY time DESC", withArgumentsIn: [pid]){
            while results.next() {
                let sid = results.int(forColumn: "sid")
                let title = results.string(forColumn: "title")
                let time = results.string(forColumn: "time")
                let location = results.string(forColumn: "location")
                let mood = results.string(forColumn: "mood")
                let photo = results.data(forColumn: "photo")
                let pid = results.int(forColumn: "pid")
                let data = AddList(sid: Int(sid), title:title! , time: time!, location: location!, mood: mood!, photo: photo!, pid: Int(pid))
                list.append(data)
            }
            results.close()
        }
        db?.close()
        return list
    }
    static func getAllBabyInfo()->[AddList]{
        var list = [AddList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let results = db?.executeQuery("SELECT * FROM AddList", withArgumentsIn: []){
            while results.next(){
                let sid = results.int(forColumn: "sid")
                let title = results.string(forColumn: "title")
                let time = results.string(forColumn: "time")
                let location = results.string(forColumn: "location")
                let mood = results.string(forColumn: "mood")
                let photo = results.data(forColumn: "photo")
                let pid = results.int(forColumn: "pid")
                let data = AddList(sid: Int(sid), title: title!, time: time!, location: location!, mood: mood!, photo: photo!, pid: Int(pid))
                //
//                let data = AddList(sid: Int(sid), name: name!, birth: birth!, gender: gender!, photo: photo)
                list.append(data)
            }
            results.close()
        }
        db?.close()
        return list
    }
    //塞篩選該日期資料
    static func getAllBabyInfoByTime(time:String)->[AddList]{
        var list = [AddList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        if let results = db?.executeQuery("SELECT * FROM AddList WHERE time = ?", withArgumentsIn: [time]){
            while results.next(){
                let sid = results.int(forColumn: "sid")
                let title = results.string(forColumn: "title")
                let time = results.string(forColumn: "time")
                let location = results.string(forColumn: "location")
                let mood = results.string(forColumn: "mood")
                let photo = results.data(forColumn: "photo")
                let pid = results.int(forColumn: "pid")
                let data = AddList(sid: Int(sid), title: title!, time: time!, location: location!, mood: mood!, photo: photo!, pid: Int(pid))
                list.append(data)
            }
            results.close()
        }
        db?.close()
        return list
    }
    static func execUpdate(_ sql:String,data:[String:Any]){
        execUpdate(sql, data: data,path:dbPath)
    }
    static func execUpdate(_ sql:String,data:[String:Any],path:String){
    let db = FMDatabase(path: path)
    db?.open()
    db?.executeUpdate(sql, withParameterDictionary: data)
    db?.close()
    }
    
    static func insert(data:AddList){
        var dict = [String:Any]()
        dict["t"] = data.title
        dict["l"] = data.location
        dict["m"] = data.mood
        dict["time"] = data.time
        dict["po"] = data.photo
        dict["pid"] = data.pid
        let sql = "INSERT INTO AddList(title,location,mood,time,photo,pid) VALUES(:t,:l,:m,:time,:po,:pid) "
        execUpdate(sql, data: dict)
    }
    static func update(data:AddList){
        var dict = [String:Any]()
        dict["t"] = data.title
        dict["l"] = data.location
        dict["m"] = data.mood
        dict["time"] = data.time
        dict["po"] = data.photo
        dict["pid"] = data.pid
        dict["sid"] = data.sid
        let sql = "UPDATE AddList SET  title=:t,location=:l,mood=:m,time=:time,photo=:po WHERE sid=:sid"
        execUpdate(sql, data: dict)
    }
    
    static func delete(sid:Int){
        var dict = [String:Any]()
        dict["sid"] = sid
        let sql = "DELETE FROM Addlist WHERE sid = :sid"
        execUpdate(sql, data: dict)
    }

}
