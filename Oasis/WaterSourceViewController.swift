//
//  WaterSourceViewController.swift
//  Oasis
//
//  Created by Tiffany Zhou on 4/22/17.
//  Copyright © 2017 Turbo Ocelots. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WaterSourceViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var type_picker: UIPickerView!
    @IBOutlet weak var condition_picker: UIPickerView!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var report_number: UILabel!
    @IBOutlet weak var reporter_label: UILabel!
    let conditionData = ["Waste", "Treatable-Clear", " Treatable-Muddy", "Potable"]
    let typeData = [  ("Bottled"),("Well"),("Stream"),("Lake"),("Spring"),("Other")]
    let userInfoRef = FIRDatabase.database().reference(withPath: "usersInfo")
    let date = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.type_picker.tag = 0;
        self.condition_picker.tag = 1;
        self.type_picker.delegate = self;
        self.condition_picker.delegate = self;
        self.type_picker.dataSource = self;
        self.condition_picker.dataSource = self;
        pullProfile();
        date_label.text = date.description;

        // Do any additional setup after loading the view.
    }
    
    // picker view setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(pickerView.tag == 0) {
            return typeData.count
        }
        else {
            return conditionData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if(pickerView.tag == 0) {
            return typeData[row]
        }
        else {
            return conditionData[row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
