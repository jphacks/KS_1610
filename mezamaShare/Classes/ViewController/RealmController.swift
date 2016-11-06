//
//  RealmController.swift
//  mezamaShare
//
//  Created by AKIO on 2016/11/06.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//
import RealmSwift

extension MainViewController {
    func idListSave() {
        let realm = try! Realm()
        // Realm init.
        try! realm.write({
            realm.deleteAll()
        })
        // ID list save by realm.
        let youID = Id()
        for data in self._listPeerIds {
            youID.id = data
            try! realm.write {
                realm.add(youID)
            }
        }
    }
    
    func idListLoad() -> String {
        let realm = try! Realm()
        var outString: String = ""
        
        for user in realm.objects(Id.self) {
            outString = user.id
        }
        
        return outString
    }
}
