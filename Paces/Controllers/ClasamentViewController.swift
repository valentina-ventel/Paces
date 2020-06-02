//
//  ModalViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 19/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ClasamentViewController: UIViewController,
                            UITableViewDataSource,
                            UITableViewDelegate {
    let dict = [Runner]()
    @IBOutlet weak var tableView: UITableView!
    var clasament = [String: Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseReference = Database.database().reference()
        let completioHandler: ([String: Double]) -> () = { clasamentDictionary in
            self.clasament = clasamentDictionary
            self.tableView.reloadData()
        }
        
        DBManager().getClasament(databaseReference, completion: completioHandler)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionCell")
        return sectionCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clasament.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = Array(clasament.keys)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ClasamentTableViewCell
        cell.distanceLabel.text = FormatterModel().distanceFormatter(distanceInMeters: Measurement(value: clasament[key]!, unit: .meters))
        cell.nameLabel.text = key
        cell.rankLabel.text = String(indexPath.row + 1)
        return cell
    }
    
}
