//
//  ModalViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 19/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit

class ClasamentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let dict = [Runner]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ClasamentTableViewCell
        
        cell.textLabel?.text = "Hello"
         
        return cell
    }
    
}
