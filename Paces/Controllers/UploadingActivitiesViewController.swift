//
//  CacaViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 02/05/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UploadingActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var routes = [Route]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routes = DBManager.myActivities()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name: .dismisModalViewController, object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "uploadingSection")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completionHandler: () -> () = {
            self.routes = DBManager.myActivities()
            self.tableView.reloadData()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "uploadingCell", for: indexPath) as! UploadingTableViewCell
        
        cell.setCell(route: routes[indexPath.row])
        cell.route = routes[indexPath.row]
        cell.completionHandler = completionHandler
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DBManager.deleteRoute(route: routes[indexPath.row])
            routes = DBManager.myActivities()
            tableView.reloadData()
        }
    }
}
