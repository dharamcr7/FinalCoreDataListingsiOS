//
//  NextViewController.swift
//  Cdata
//
//  Created by Dharam Singh on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
  
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var tutionTxtField: UITextField!
    @IBOutlet weak var startDateTxtField: UITextField!
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let name = nameTxtField.text
        let age = ageTxtField.text
        let tution = tutionTxtField.text
        let startDate = startDateTxtField.text
        
        
        if (name == "" && age == "" && tution == "" && startDate == ""){
            
            return
        }
        let vc = self.navigationController?.viewControllers.first as! ViewController
        vc.pName = name ?? ""
        vc.pAge = Int(age!) ?? 0
        vc.pTution = Double(tution!) ?? 0.0
        vc.pStartDate = (startDate!)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        
    }
    
    
}

extension NextViewController{
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startDateTxtField.inputAccessoryView = toolbar
        startDateTxtField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        startDateTxtField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func checkEmpty(msg: String,isEmpty: Bool){
        
        
        
    }
}
