//
//  EnterRoomViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit
import RealmSwift

class EnterRoomView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let userDefault = UserDefaults.standard
    var items: [String] = []
    weak var callback: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // -----
//        let realm = try! Realm()
//        
//        var count: Int = 0
//        for user in realm.objects(Id.self) {
//            NSLog("count:\(count)")
//            items.append(user.id)
//            count += 1
//        }
        
        if ((userDefault.object(forKey: "id")) != nil) {
            let objects = userDefault.object(forKey: "id") as? NSArray
            
            var i: Int = 0
            for nameString in objects!{
                items.append((nameString as! NSString) as String)
                i += 1
            }
        }
        // -----
        
        enterButton.addTarget(MainViewController(), action: #selector(MainViewController.onEnterRoom(sender:)), for: .touchUpInside)
        
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strTo: String = (self.items[(indexPath as NSIndexPath).row] as String)
        
//        let youID = Id()
//        let realm = try! Realm()
//        
//        try! realm.write({
//            realm.deleteAll()
//        })
//        
//        youID.id = strTo
//        try! realm.write {
//            realm.add(youID)
//        }
        userDefault.removeObject(forKey: "id")
        
        userDefault.set([strTo], forKey:"id")
        userDefault.synchronize()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        cell.textLabel!.text = items[(indexPath as NSIndexPath).row] as String
        cell.textLabel?.font = UIFont(name: "CometStd-B", size: 17)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
}
