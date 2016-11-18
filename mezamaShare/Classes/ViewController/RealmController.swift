//
//  RealmController.swift
//  mezamaShare
//
//  Created by AKIO on 2016/11/06.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//
import RealmSwift

extension MainViewController {
//    func idListSave() {
//        let realm = try! Realm()
//        // Realm init.
//        try! realm.write({
//            realm.deleteAll()
//        })
//        // ID list save by realm.
//        let youID = Id()
//        print(self._listPeerIds)
//        for data in self._listPeerIds {
//            youID.id = data
//            try! realm.write {
//                realm.add(youID)
//            }
//        }
//    }
    
    func idListSave() {
        userDefault.removeObject(forKey: "id")
        
        userDefault.set(self._listPeerIds, forKey:"id")
        userDefault.synchronize()
    }
    
    
//    func idListLoad() -> String {
//        let realm = try! Realm()
//        var outString: String = ""
//        
//        for user in realm.objects(Id.self) {
//            outString = user.id
//        }
//        
//        return outString
//    }
    
    func idListLoad() -> String {
        var outString: String = ""
        
        if ((userDefault.object(forKey: "id")) != nil) {
            let objects = userDefault.object(forKey: "id") as? NSArray
        
            var i: Int = 0
            for nameString in objects!{
                outString = (nameString as! NSString) as String
                i += 1
            }
        }
        return outString
    }
}
