//
//  AuthorizationViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 5/8/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import RNCryptor

class AuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        stack.spacing = self.view.frame.height / 20
        loginField.font = loginField.font!.withSize(self.view.frame.height / 50)
        passwordField.font = passwordField.font!.withSize(self.view.frame.height / 50)
        nameField.font = nameField.font!.withSize(self.view.frame.height / 50)
        dateField.font = dateField.font!.withSize(self.view.frame.height / 50)
        companyField.font = companyField.font!.withSize(self.view.frame.height / 50)
        loginLabel.font = loginLabel.font!.withSize(self.view.frame.height / 30)
        nameLabel.font = nameLabel.font!.withSize(self.view.frame.height / 30)
        passwordLabel.font = passwordLabel.font!.withSize(self.view.frame.height / 30)
        dateLabel.font = dateLabel.font!.withSize(self.view.frame.height / 30)
        companyLabel.font = companyLabel.font!.withSize(self.view.frame.height / 30)
        registrOutlet.titleLabel?.font = registrOutlet.titleLabel?.font.withSize(self.view.frame.height / 30)
        authorOutlet.titleLabel?.font = authorOutlet.titleLabel?.font.withSize(self.view.frame.height / 30)
        nextOutlet.titleLabel?.font = nextOutlet.titleLabel?.font.withSize(self.view.frame.height / 30)
    }
    
    var access = "new user"
    var userPasswordFromDB = "0"
    var sem1 = DispatchSemaphore(value: 0)
    
    @IBOutlet weak var registrOutlet: UIButton!
    @IBOutlet weak var authorOutlet: UIButton!
    
    @IBOutlet weak var nextOutlet: UIButton!
    
    var User1 = User()
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBAction func nextPage(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Помилка!", message:
            "Hello, world!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default))
        if loginField.text!.count > 7 && passwordField.text!.count > 7 {
            let encryptedMessage = encryptMessage(message: passwordField.text!)
            let data = ["login" : loginField.text! , "password" : encryptedMessage, "dateOFBirth" : dateField.text! , "company" : companyField.text! , "name" : nameField.text! , "role" : "Admin"]
            server(dataDictionary: data)
            sem1.wait()
            if userPasswordFromDB != "0" {
                let decryptedPassword = try! decryptMessage(encryptedMessage: userPasswordFromDB)
                if decryptedPassword == passwordField.text! {
                    access = "true"
                }
                else {
                    alertController.message = "Такий логін вже існує і ви ввели невірний пароль"
                    present(alertController, animated: true, completion: nil)
                    access = "false"
                }
            }
        }
        else {
            alertController.message = "Логін та пароль мають складатися як мінімум з 8 символів"
            present(alertController, animated: true, completion: nil)
            access = "false"
        }
        if access == "true"{
            User1 = User(loginField.text!, passwordField.text!)
            User1.dateOfBirth = dateOfBirth
            User1.company = company
            User1.name = name
            performSegue(withIdentifier: "creator", sender: self)
        }
        if access == "new user" {
            User1 = User(loginField.text!, passwordField.text!)
            User1.dateOfBirth = dateField.text!
            User1.company = companyField.text!
            User1.name = nameField.text!
            performSegue(withIdentifier: "creator", sender: self)
        }
        //generateEncryptionKey()
        //performSegue(withIdentifier: "creator", sender: self)
    }
    
    @IBOutlet weak var stack: UIStackView!
    @IBAction func authorization(_ sender: UIButton) {
        nameField.isHidden = true
        dateField.isHidden = true
        companyField.isHidden = true
        nameLabel.isHidden = true
        dateLabel.isHidden = true
        companyLabel.isHidden = true
        loginLabel.isHidden = false
        passwordLabel.isHidden = false
        loginField.isHidden = false
        passwordField.isHidden = false
    }
    
    var dateOfBirth: String!
    var company: String!
    var name: String!
    @IBAction func registration(_ sender: UIButton) {
        nameField.isHidden = false
        dateField.isHidden = false
        companyField.isHidden = false
        nameLabel.isHidden = false
        dateLabel.isHidden = false
        companyLabel.isHidden = false
        loginLabel.isHidden = false
        passwordLabel.isHidden = false
        loginField.isHidden = false
        passwordField.isHidden = false
    }
    
    
    let password = "0RbuS0MScw1bz4kY6oRefAxZ/hPbrNRM52ab4pio2og="
    
    func encryptMessage(message: String) -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: password)
        return cipherData.base64EncodedString()
    }
    
    func server (dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/")!
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
            
            
            if responseString != "inserted" {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let array = json as? [String : Any] {
                        // print(json)
                        self.userPasswordFromDB = (array["password"] as? String)!
                        self.company = (array["company"] as? String)!
                        self.dateOfBirth = (array["dateOFBirth"] as? String)!
                        self.name = (array["name"] as? String)!
                    }
                }
                catch {
                    print("Couldn't parse json \(error)")
                }
                //self.userPasswordFromDB = responseString!
            }
            self.sem1.signal()
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let CreatorVC = segue.destination as? CreatorViewController{
            CreatorVC.User1 = User1
        }
    }
    
    


    func decryptMessage(encryptedMessage: String) throws -> String {

        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: password)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
    
//    func generateEncryptionKey() {
//        let randomData = RNCryptor.randomData(ofLength: 32)
//        print(randomData.base64EncodedString())
//    }
    
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if identifier == "menu" {
//
//        }
//    }
    
    
    

}



