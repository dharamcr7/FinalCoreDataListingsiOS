//
//  AddViewController.swift
//  Cdata
//
//  Created by Dharam Singh on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var name = ""
    var age = 0
    var tution = 0.0
    var startDate = ""
    var edit = true
    var index = 0
    var person = Person()
      let formatter = DateFormatter()
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var tutionTxtField: UITextField!
    @IBOutlet weak var startDateTxtField: UITextField!
    
    
    
    @IBAction func editBtnPress(_ sender: Any) {
        
        name = nameTxtField.text!
        age = Int(ageTxtField.text!) ?? 0
        tution = Double(tutionTxtField.text!) ?? 0.0
        startDate = startDateTxtField.text!
        let vc = self.navigationController?.viewControllers.first as! ViewController
        vc.pName = name
        vc.pAge = age
        vc.pTution = tution
        vc.pStartDate = startDate
        vc.edit = true
        print(name)
       
          formatter.dateStyle = .long
              formatter.timeStyle = .none
       
        self.appdelegate.updateRecord(person: person, name: name, age: age, tution: tution, startDate: formatter.date(from: startDate)!)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        startDateTxtField.text = startDate
        nameTxtField.text = name
        ageTxtField.text = String(age)
        tutionTxtField.text = String(tution)
    }
    
    
}
