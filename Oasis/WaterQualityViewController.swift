
//
//  WaterQualityViewController.swift
//  Oasis
//
//  Created by Tiffany Zhou on 4/22/17.
//  Copyright © 2017 Turbo Ocelots. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WaterQualityViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {


    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var reporter_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var ReportID_label: UILabel!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var virus: UITextField!
    @IBOutlet weak var contam: UITextField!
    @IBOutlet weak var oCondtion_picker: UIPickerView!
    
    let userInfoRef = FIRDatabase.database().reference(withPath: "usersInfo")
    let reportRef = FIRDatabase.database().reference(withPath: "report")
    let ref = FIRDatabase.database().reference()
    var oCondition: String = "";
    let conditionData = [("Safe"),("Treatable"),("Unsafe")]
    let date = NSDate()
    var reportId: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        status.text = " ";
        self.oCondtion_picker.delegate = self;
        self.oCondtion_picker.dataSource = self;
        pullProfile();
        date_label.text = date.description;
        ReportID_label.text = "0";

        // Do any additional setup after loading the view.
    }
    
   // get Report username
    func pullProfile(){
        let userID = FIRAuth.auth()?.currentUser?.uid
        userInfoRef.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let email = value?["email"] as? String ?? ""
            self.reporter_label.text=email;
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
        
//        reportRef.child("reportCount").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let reportId = value?["reportCount"] as? String ?? ""
//            self.ReportID_label.text = reportId;
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }

        
  //  }

    
    // picker view setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            self.oCondition = conditionData[row] as String
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
  
            return conditionData.count

    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
            return conditionData[row]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submit_Report(_ sender: UIButton) {
        if(virus.hasText == false || contam.hasText == false) {
            status.text = "Please enter Virus PPM and/or Contam. PPM"
        }
        else if(long.hasText == false || lat.hasText == false) {
            status.text = "Please enter Longtitude and/or Latitude"
        } else {
            let newReportRef = self.reportRef.childByAutoId();
            let reportData : Dictionary<String,String> = ["reporter": reporter_label.text!,"date" : date.description,
                "long": long.text!,
                "lat": lat.text!,
                "condition": "",
                "type": "",
                "oCondition": self.oCondition,
                "virus" : self.virus.text!,
                "contam" : self.contam.text!,
                "reportType" : "Water Quality Report"]
            newReportRef.setValue(reportData)
            self.performSegue(withIdentifier: "toHome", sender: self)
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
