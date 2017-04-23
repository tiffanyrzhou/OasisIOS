//
//  ViewReportTableViewController.swift
//  Oasis
//
//  Created by Tiffany Zhou on 4/23/17.
//  Copyright © 2017 Turbo Ocelots. All rights reserved.
//

import UIKit
import Firebase

class ViewReportTableViewController: UITableViewController {
    var reports = [Report]()
    let Ref = FIRDatabase.database().reference(withPath: "report")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        Ref.queryOrderedByKey().observeSingleEvent(of: .childAdded,with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let long  = value?["long"] as? String ?? ""
            let lat = value?["lat"] as? String ?? ""
            let condition = value?["condition"] as? String ?? ""
            let oCondition = value?["oCondition"] as? String ?? ""
            let type = value?["type"] as? String ?? ""
            let virus = value?["virus"] as? String ?? ""
            let contam = value?["cotam"] as? String ?? ""
            let reporter =  value?["reporter"] as? String ?? ""
            let id = snapshot.key;
            self.reports.append(Report(id: id,long: long,lat: lat,oCondition: oCondition,condition: condition,type: type,reporter: reporter,virus: virus,contam: contam))
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        self.tableView.reloadData();
        
        
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.reports.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)
        
        let id = cell.viewWithTag(1)as! UILabel
        id.text=reports[indexPath.row].id
        
        let reporter = cell.viewWithTag(2) as! UILabel
        reporter.text = reports[indexPath.row].reporter
        
        let type = cell.viewWithTag(3) as! UILabel
        type.text = reports[indexPath.row].condition
        
        let condition = cell.viewWithTag(4) as! UILabel
        condition.text = reports[indexPath.row].condition
        
        let virus = cell.viewWithTag(5) as! UILabel
        virus.text = reports[indexPath.row].condition
        
        let contam = cell.viewWithTag(6) as! UILabel
        contam.text = reports[indexPath.row].contam
        
        let lat = cell.viewWithTag(7) as! UILabel
        lat.text = reports[indexPath.row].lat
        
        let long = cell.viewWithTag(8) as! UILabel
        long.text = reports[indexPath.row].long
        
        let oCondition = cell.viewWithTag(9) as! UILabel
        oCondition.text = reports[indexPath.row].oCondition
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
