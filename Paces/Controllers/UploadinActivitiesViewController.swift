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

class UploadinActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var routes = [Route]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routes = DBManager.myActivities()
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
}
