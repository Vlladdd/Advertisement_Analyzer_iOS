//
//  CreatorViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 5/16/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import iOSDropDown


class CreatorViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let data = ["login" : User1.login]
        server1(data)
        sem1.wait()
        nameUploadUser.optionArray = names
        source.optionArray = ["MongoDB"]
        // Do any additional setup after loading the view.
    }
    
    var upload = true
    
    @IBAction func create(_ sender: UIButton) {
        upload = false
        for x in create {
            x.isHidden = false
        }
        nameCreateUser.isHidden = false
        budget.isHidden = false
        source.isHidden = false
        sourceWay.isHidden = false
        nameUpload.isHidden = true
        nameUploadUser.isHidden = true
        fieldNames.isHidden = false
        dateInDBLabel.isHidden = false
        dateInDBField.isHidden = false
        nameInDBLabel.isHidden = false
        nameInDBField.isHidden = false
        newClientsLabel.isHidden = false
        newClientsField.isHidden = false
        salesLabel.isHidden = false
        salesField.isHidden = false
        profitLabel.isHidden = false
        profitField.isHidden = false
        wasteLabel.isHidden = false
        wasteField.isHidden = false
        productNameField.isHidden = false
        productNameLabel.isHidden = false
        bdLabel.isHidden = false
        bdField.isHidden = false
        tableLabel.isHidden = false
        tableField.isHidden = false
    }
    @IBAction func upload(_ sender: UIButton) {
        upload = true
        for x in create {
            x.isHidden = true
        }
        nameCreateUser.isHidden = true
        budget.isHidden = true
        source.isHidden = true
        sourceWay.isHidden = true
        nameUpload.isHidden = false
        nameUploadUser.isHidden = false
        fieldNames.isHidden = true
        dateInDBLabel.isHidden = true
        dateInDBField.isHidden = true
        nameInDBLabel.isHidden = true
        nameInDBField.isHidden = true
        newClientsLabel.isHidden = true
        newClientsField.isHidden = true
        salesLabel.isHidden = true
        salesField.isHidden = true
        profitLabel.isHidden = true
        profitField.isHidden = true
        wasteLabel.isHidden = true
        wasteField.isHidden = true
        productNameField.isHidden = true
        productNameLabel.isHidden = true
        bdLabel.isHidden = true
        bdField.isHidden = true
        tableLabel.isHidden = true
        tableField.isHidden = true
    }
    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var fieldNames: UILabel!
    @IBOutlet weak var dateInDBLabel: UILabel!
    @IBOutlet weak var dateInDBField: UITextField!
    @IBOutlet weak var nameInDBLabel: UILabel!
    @IBOutlet weak var nameInDBField: UITextField!
    @IBOutlet weak var newClientsLabel: UILabel!
    @IBOutlet weak var newClientsField: UITextField!
    @IBOutlet weak var salesLabel: UILabel!
    @IBOutlet weak var salesField: UITextField!
    @IBOutlet weak var profitLabel: UILabel!
    @IBOutlet weak var profitField: UITextField!
    @IBOutlet weak var wasteLabel: UILabel!
    @IBOutlet weak var wasteField: UITextField!
    @IBOutlet weak var bdLabel: UILabel!
    @IBOutlet weak var bdField: UITextField!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var tableField: UITextField!
    
    
    
    @IBOutlet weak var nameUpload: UILabel!
    @IBOutlet var create: [UILabel]!
  
    var User1 = User()
    var names = [String]()
    var Analyzer1 = Analyzer()
    var sem1 = DispatchSemaphore(value: 0)

    @IBOutlet weak var nameUploadUser: DropDown!
 
    @IBOutlet weak var nameCreateUser: UITextField!
    
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var source: DropDown!
    @IBOutlet weak var sourceWay: UITextField!
    @IBAction func nextPage(_ sender: UIButton) {
        if upload == false && nameCreateUser.text != nil && budget.text != nil && source.text != nil && sourceWay.text != nil && nameUploadUser.text != nil && dateInDBField.text != nil && nameInDBField.text != nil && newClientsField.text != nil && salesField.text != nil && profitField.text != nil && wasteField.text != nil && productNameField.text != nil && bdField.text != nil && tableField.text != nil {
            if let _ = Int(budget.text!){
                performSegue(withIdentifier: "mainPage", sender: self)
            }
        }
        else {
            performSegue(withIdentifier: "mainPage", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? TabBarViewController{
            let MainVC = tabBarController.viewControllers![0] as? MainViewController
            let UserVC = tabBarController.viewControllers![3] as? UserViewController
            UserVC?.User1 = User1
            if upload == false {
                let date = Date()
                let calendar = Calendar.current
                let result = calendar.component(.day, from: date)
                let startMonth = calendar.component(.month, from: date)
                let startYear = calendar.component(.year, from: date)
                var startWeek = 0
                if result >= 1 && result <= 7{
                    startWeek = 1
                }
                if result >= 8 && result <= 14{
                    startWeek = 2
                }
                if result >= 15 && result <= 21{
                    startWeek = 3
                }
                if result >= 22 && result <= 28{
                    startWeek = 4
                }
                if result >= 29 && result <= 31{
                    startWeek = 5
                }
                MainVC?.Analyzer1.budget = Int(budget.text!)
                MainVC?.Analyzer1.startDate = result
                MainVC?.Analyzer1.startMonth = startMonth
                MainVC?.Analyzer1.startWeek = startWeek
                MainVC?.Analyzer1.startYear = startYear
                MainVC?.Analyzer1.userNames.append(User1.login)
                MainVC?.Analyzer1.name = nameCreateUser.text
                MainVC?.Analyzer1.sourceName = sourceWay.text
                MainVC?.Analyzer1.productNameField = productNameField.text
                MainVC?.Analyzer1.dateInDB = dateInDBField.text
                MainVC?.Analyzer1.sourceNameInDB = nameInDBField.text
                MainVC?.Analyzer1.newClientsInDB = newClientsField.text
                MainVC?.Analyzer1.salesInDB = salesField.text
                MainVC?.Analyzer1.profitInDB = profitField.text
                MainVC?.Analyzer1.wasteInDB = wasteField.text
                MainVC?.Analyzer1.bdName = bdField.text
                MainVC?.Analyzer1.tableName = tableField.text
                Analyzer1.addAction(User1.login, Date(), "Створив файл")
                MainVC?.Analyzer1.actionList = Analyzer1.actionList
                let userNames = [User1.login]
                let userNames1 = [String]()
                let data = ["name" : nameCreateUser.text! , "budget" : Int(budget.text!)!, "startMonth" : startMonth, "startDate" : result, "startYear" : startYear, "startWeek" : startWeek, "sourceWay" : sourceWay.text!, "userNames" : userNames, "defaultUserNames" : userNames1, "productName" : productNameField.text!, "dateInDB": dateInDBField.text!, "sourceNameInDB": nameInDBField.text!, "newClientsInDB": newClientsField.text!, "salesInDB": salesField.text!, "profitInDB": profitField.text!, "wasteInDB": wasteField.text!, "bdName": bdField.text!, "tableName": tableField.text!] as [String : Any]
                server(data)
                var actions = [String]()
                for x in Analyzer1.actionList{
                    actions.append(x.action)
                }
                let data2 = ["name" : nameCreateUser.text! , "actions" : actions] as [String : Any]
                server5(data2)
            }
            else {
                let data = ["name" : nameUploadUser.text!]
                server3(data)
                server7(data)
                sem1.wait()
                MainVC?.Analyzer1 = Analyzer1
            }
            tabBarController.Analyzer1 = Analyzer1
            tabBarController.User1 = User1
        }
    }
    
    func server (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/file")!
        var request = URLRequest(url: url)
       // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dataDictionary)
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            //let responseString = String(data: data, encoding: .utf8)
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func server5 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/list")!
        var request = URLRequest(url: url)
       // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dataDictionary)
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            //let responseString = String(data: data, encoding: .utf8)
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func server7 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/findList")!
        var request = URLRequest(url: url)
       // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dataDictionary)
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [String] {
                    // print(json)
                    for x in array{
                        self.Analyzer1.addAction(x)
                    }
                }
            }
            catch {
                print("Couldn't parse json \(error)")
            }
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func server1 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/findFiles")!
        var request = URLRequest(url: url)
       // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dataDictionary)
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            var first = false
            var result = ""
            var count = 0
            for x in responseString! {
                if x == "\"" {
                    if first == false {
                        first = true
                    }
                    else {
                        first = false
                    }
                    count += 1
                }
                if first == true {
                    if x != "\"" {
                        result.append(x)
                    }
                }
                if count == 2 {
                    self.names.append(result)
                    result = ""
                    count = 0
                }
            }
            
            self.sem1.signal()
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func server3 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/findFile")!
        var request = URLRequest(url: url)
       // request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: dataDictionary)
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            //let responseString = String(data: data, encoding: .utf8)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [String : Any] {
                    // print(json)
                        self.Analyzer1.budget = array["budget"] as? Int
                        self.Analyzer1.startDate = array["startDate"] as? Int
                        self.Analyzer1.startMonth = array["startMonth"] as? Int
                        self.Analyzer1.startWeek = array["startWeek"] as? Int
                        self.Analyzer1.startYear = array["startYear"] as? Int
                        self.Analyzer1.userNames = (array["userNames"] as? [String])!
                        self.Analyzer1.name = array["name"] as? String
                        self.Analyzer1.sourceName = array["sourceWay"] as? String
                        self.Analyzer1.productNameField = array["productName"] as? String
                        self.Analyzer1.dateInDB = array["dateInDB"] as? String
                        self.Analyzer1.sourceNameInDB = array["sourceNameInDB"] as? String
                        self.Analyzer1.newClientsInDB = array["newClientsInDB"] as? String
                        self.Analyzer1.salesInDB = array["salesInDB"] as? String
                        self.Analyzer1.profitInDB = array["profitInDB"] as? String
                        self.Analyzer1.wasteInDB = array["wasteInDB"] as? String
                        self.Analyzer1.bdName = array["bdName"] as? String
                        self.Analyzer1.tableName = array["tableName"] as? String
                }
            }
            catch {
                print("Couldn't parse json \(error)")
            }
            
            self.sem1.signal()
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    

}
