//
//  MyActivityViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit


class MyActivityViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var activities = [RLMRoute]()
    var example = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activities = DBManager.myActivities()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(example.min())
        print(example.max())

        // Do any additional setup after loading the view.
        print("We have \(activities.count) in DB")
        tableView.reloadData()
    }
    

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let route = activities[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        
        cell.distanceLabel.text = String(format: "%.1f m", route.distance)
        cell.dateLabel.text = route.date
        cell.durationLabel.text = "\(String(route.time))s"
        
        return cell
    }

    
}
