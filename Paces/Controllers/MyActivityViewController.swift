//
//  MyActivityViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

class MyActivityViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var activities = [Route]()
    var dict = [Date:[Route]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activities = DBManager.myActivities()
        
         for activity in activities {
            print("FROM \(activity.date)")
            let calendar = Calendar.current
            let year = calendar.component(.year, from: activity.date)
            let month = calendar.component(.month, from: activity.date)
            print("Y \(year), M \(month)")
          
            let dateComponents = DateComponents(calendar: calendar,
                                                year: year,
                                                month: month,
                                                day: 1)
            
            let firstDay = calendar.date(from: dateComponents)!
            print("  TO \(firstDay)")
            if dict[firstDay] == nil  {
                dict[firstDay] = [activity]
            } else {
                dict[firstDay]?.append(activity)
            }
        }
        print(dict.keys)
        tableView.reloadData()
    }

    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dict.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keyDate = Array(dict.keys).sorted{$0 > $1}[section]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        let firstDayString = dateFormatter.string(from: keyDate)
       
        return firstDayString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dict.keys).sorted{$0 > $1}[section]
        let activitiesForSection = dict[key]
        return activitiesForSection!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = Array(dict.keys).sorted{$0 > $1}[indexPath.section]
        let activitiesForSection = dict[key]
        
        let route = activitiesForSection![indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        cell.setup(with: route)
        return cell
    }
}


