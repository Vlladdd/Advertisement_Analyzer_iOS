//
//  UserViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 5/28/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
     //   let data = ["login": User1.login]
//        server3(data)
//        sem1.wait()
        updateUser()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var actionListOutlet: UIButton!
    override func viewDidAppear(_ animated: Bool) {
        updateUser()
        if let tbc = tabBarController as? TabBarViewController {
            Analyzer1 = tbc.Analyzer1
        }
        if Analyzer1.userNames.contains(User1.login) == false{
            actionListOutlet.isHidden = true
        }
        Analyzer1.addAction(User1.login, Date(), "Перейшов в особистий кабінет")
        updateList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            tbc.Analyzer1 = Analyzer1
        }
    }
    func updateUser(){
        login.text = User1.login
        password.text = User1.password
        name.text = User1.name
        date.text = User1.dateOfBirth
        company.text = User1.company
    }
    
    func updateList() {
        var actions = [String]()
        for x in Analyzer1.actionList{
            actions.append(x.action)
        }
        let data2 = ["name" : Analyzer1.name! , "actions" : actions] as [String : Any]
        server6(data2)
    }
    var Analyzer1 = Analyzer()
    var User1 = User()
    var sem1 = DispatchSemaphore(value: 0)
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBAction func actionList(_ sender: UIButton) {
        performSegue(withIdentifier: "action", sender: self)
    }
    
    @IBAction func info(_ sender: UIButton) {
        performSegue(withIdentifier: "info", sender: self)
    }
    

    @IBAction func update(_ sender: UIButton) {
//        let alertController = UIAlertController(title: "Помилка!", message:
//            "Hello, world!", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Ок", style: .default))
//        alertController.message = "Логін має бути більше 8 і менше 16 символів"
//        present(alertController, animated: true, completion: nil)
        if login.text!.count > 7 && password.text!.count > 7 && login.text!.count < 16 && password.text!.count < 16{
            User1.updateUser(login.text!, password.text!, date.text!, company.text!, name.text!)
            updateUser()
            let data = ["login" : login.text! , "dateOfBirth" : date.text! , "company" : company.text! , "name" : name.text!]
            server(data)
        }
    }
    
    @IBAction func backFromModal(_ segue: UIStoryboardSegue) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ActionVC = segue.destination as? ActionViewController{
            ActionVC.Analyzer1 = Analyzer1
        }
    }
    
    func server3 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/findUser")!
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
                    self.User1.login = (array["login"] as? String)!
                    self.User1.dateOfBirth = (array["dateOFBirth"] as? String) ?? ""
                    self.User1.company = (array["company"] as? String) ?? ""
                    self.User1.name = (array["name"] as? String) ?? ""
                    self.User1.role = (array["role"] as? String) ?? ""
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
    
    func server (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/editUser")!
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
    
    func server6 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/updateList")!
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

}
