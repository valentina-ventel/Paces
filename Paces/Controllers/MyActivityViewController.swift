
import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class MyActivityViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var dict = [Date:[Route]]()
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSpinner()
        
        let databaseReference = Database.database().reference()
        let completionHandler: ([Date: [Route]]) -> () = { remoteDict in
            print("Reloading table for \(remoteDict.keys) active days...")
            self.dict = remoteDict
            self.tableView.reloadData()
            
            self.spinner.removeFromSuperview()
            
        }
        
        DBManager.remoteRoutes(databaseReference: databaseReference,
                               completion: completionHandler)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData(notification:)), name: .dismisModalViewController, object: nil)
        
    }
    
    @objc func reloadData(notification: NSNotification) {
        showSpinner()
        
        let databaseReference = Database.database().reference()
        let completionHandler: ([Date: [Route]]) -> () = { remoteDict in
            print("Reloading table for \(remoteDict.keys) active days...")
            self.dict = remoteDict
            self.tableView.reloadData()
            
            self.spinner.removeFromSuperview()
            
        }
        
        DBManager.remoteRoutes(databaseReference: databaseReference,
                               completion: completionHandler)
    }
    
    fileprivate func showSpinner() {
        //show a spinner
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        //center spinner
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dict.keys.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            let keyDate = Array(dict.keys).sorted{$0 > $1}[section - 1]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM YYYY"
            let firstDayString = dateFormatter.string(from: keyDate)
           
            return firstDayString
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let key = Array(dict.keys).sorted{$0 > $1}[section - 1]
            let activitiesForSection = dict[key]
            print(section) 
            return activitiesForSection!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileTableViewCell
            return cell
        } else {
            
            let key = Array(dict.keys).sorted{$0 > $1}[indexPath.section - 1]
            
            let activitiesForSection = dict[key]
        
            let route = activitiesForSection![indexPath.row]
            print("IndexPath = \(indexPath.row)")

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
            cell.setup(with: route)
            return cell
        }
    }
}


