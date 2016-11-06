//
//  IdRealm.swift
//  mezamaShare
//
//  Created by Ellie NAGAISHI on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

/*import RealmSwift
 
 
 let me = Id()
 me.id = "akkey"
 
 let realm = try! Realm()
 //書き込み
 try! realm.write {
 realm.add(me)
 }
 //取得
 for user in realm.objects(Id.self) {
 NSLog("result\(user)")
 }
 
 realm.objects(Id.self)
 //全件削除
 try! realm.write({
 realm.deleteAll()
 })

 */

import UIKit
import RealmSwift

class Id: Object {
    dynamic var id: String = ""
}

