//
//  ViewController.swift
//  Cdata
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var pName = ""
    var pAge = 0
    var pTution = 0.0
    var pStartDate = ""
    var index = 0
    var edit = false
    var date = Date()
    
    var perArray = [Person]()
    var filterArray = [Person]()
    let formatter = DateFormatter()
    
    @IBOutlet weak var serachBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        serachBar.delegate = self
        
        filterArray = perArray
        
        let nib = UINib.init(nibName: "PersonDetailTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PersonDetailTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(pName)
        fetchAndUpdateTable()
        dataToTxt()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArray = searchText.isEmpty ? perArray : perArray.filter({ (personString: Person) -> Bool in
            
            return personString.name?.range(of: searchText, options:  .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    
}

// Tableview Datasource and Delegate

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ChecklistCell
        let person = filterArray[indexPath.row]
        cell.nameLbl?.text = person.name!
        cell.ageLbl?.text =  String(person.age)
        cell.tutionLbl.text = String(person.tution)
        
        let dateformater = DateFormatter()
        dateformater.dateStyle = .long
        dateformater.timeStyle = .none
        
        cell.dateLbl.text = dateformater.string(from:person.startDate!)
        // cell?.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let person = perArray[indexPath.row]
            appdelegate.deleteRecord(person: person)
            fetchAndUpdateTable()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
            formatter.dateStyle = .long
                   formatter.timeStyle = .none
            
            viewController.name = filterArray[indexPath.row].name!
            viewController.age = Int(filterArray[indexPath.row].age)
            viewController.tution = filterArray[indexPath.row].tution
            viewController.startDate = formatter.string(from:  filterArray[indexPath.row].startDate!)
            viewController.index = indexPath.row
            viewController.person = filterArray[indexPath.row]
            
            // viewController.title = filterArray[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
        
        
        
        
        //        let person = perArray[indexPath.row]
        //
        //        var nameTxt: UITextField?
        //        var addressTxt: UITextField?
        //
        //        let alert = UIAlertController(title: "Alert", message: "update", preferredStyle: .alert)
        //
        //
        //
        //        let ok = UIAlertAction(title: "update", style: .default, handler: { (action) -> Void  in
        //
        //            let name = nameTxt?.text
        //            let addres = addressTxt?.text
        //
        //            if (name != nil && addres != nil){
        //                self.appdelegate.updateRecord(person: person, name: name!, address: addres!)
        //                self.fetchAndUpdateTable()
        //            }
        //        })
        //        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
        //
        //             print("cancel")
        //              })
        //            alert.addAction(ok)
        //            alert.addAction(cancel)
        //
        //        alert.addTextField { (textField) in
        //           nameTxt = textField
        //            nameTxt?.placeholder = "add name"
        //            nameTxt?.text = person.name
        //        }
        //        alert.addTextField { (textField) in
        //                addressTxt = textField
        //                 addressTxt?.placeholder = "add address"
        //            addressTxt?.text = person.address
        //             }
        //        self.present(alert, animated: true, completion: nil)
        //
        //
        
    }
    
}

extension ViewController:DelegateMethod{
    
    
    func addListItem(cell: ChecklistCell) {
        if let indexPath = tableView.indexPath(for: cell){
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NextViewController") as? NextViewController {
                
                // viewController.title = filterArray[indexPath.row]
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
    }
    
    
}
protocol DelegateMethod {
    func addListItem(cell: ChecklistCell)
}

class ChecklistCell: UITableViewCell{

var delegate: DelegateMethod?
@IBOutlet weak var nameLbl: UILabel!
@IBOutlet weak var ageLbl: UILabel!
@IBOutlet weak var tutionLbl: UILabel!

@IBOutlet weak var dateLbl: UILabel!
@IBAction func btnTapppd(_ sender: Any) {

delegate?.addListItem(cell: self)
}

}

extension  ViewController{
    
    // Button Actions
    
    @IBAction func addBarBtnpressed(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NextViewController") as?  NextViewController {
            // viewController.keyBoolean = selectedItem
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    @IBAction func add(_ sender: Any) {
        
        var nameTxt: UITextField?
        var ageTxt: UITextField?
        var tutionTxt: UITextField?
        var startDatext: UITextField?
        
        
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        
        
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void  in
            
            let name = nameTxt?.text
            let age = ageTxt?.text
            let tution = tutionTxt?.text
            let startDate = startDatext?.text
            
            
            if (name != nil && age != nil){
                self.appdelegate.insertRecord(name: nameTxt?.text ?? "", age: Int((ageTxt?.text!)!) ?? 0, tution:  0.0 , startDate: NSDate() as Date)
                self.fetchAndUpdateTable()
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
            
            print("cancel")
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.addTextField { (textField) in
            nameTxt = textField
            nameTxt?.placeholder = "add name"
        }
        alert.addTextField { (textField) in
            ageTxt = textField
            ageTxt?.placeholder = "add address"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // All Functions
    func dataToTxt(){
        
        if edit == true{
            self.fetchAndUpdateTable()
            
            return
        }
        //                    self.appdelegate.updateRecord(person: perArray[index], name: pName, age: pAge, tution: pTution, startDate: NSDate() as Date)
        self.fetchAndUpdateTable()
        
        if pName == ""{
            return
        }
        let dateformater = DateFormatter()
        dateformater.dateStyle = .long
        dateformater.timeStyle = .none
        
        self.appdelegate.insertRecord(name: pName, age: pAge, tution: pTution, startDate:  dateformater.date(from: pStartDate)!)
        self.fetchAndUpdateTable()
        
        
    }
    func fetchAndUpdateTable(){
        perArray = appdelegate.fetchRecords()
        filterArray = perArray
        tableView.reloadData()
    }
}
