//
//  EnterRoomViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit
import RealmSwift

class EnterRoomViewController: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var items: [String] = []
    weak var callback: UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // -----
        let realm = try! Realm()
        
        var count: Int = 0
        for user in realm.objects(Id.self) {
            NSLog("count:\(count)")
            items.append(user.id)
            count += 1
        }
        // -----
        
        enterButton.addTarget(MainViewController(), action: #selector(MainViewController.onEnterBuddyRoom(sender:)), for: .touchUpInside)
        
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strTo: String = (self.items[(indexPath as NSIndexPath).row] as String)
        
        let youID = Id()
        let realm = try! Realm()
        
        try! realm.write({
            realm.deleteAll()
        })
        
        youID.id = strTo
        try! realm.write {
            realm.add(youID)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        cell.textLabel!.text = items[(indexPath as NSIndexPath).row] as String
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
}
