//
//  ActionViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 5/28/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillList()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        performSegue(withIdentifier: "userProf", sender: self)
    }
    @IBOutlet weak var actions: UIStackView!
    
    var Analyzer1 = Analyzer()
    
    @IBOutlet weak var userName: UITextField!
    var pagesIndex = 0
    
    @IBAction func makeAdmin(_ sender: UIButton) {
        if userName.text != nil{
            let data = ["name" : Analyzer1.name!, "type": "admin", "login": userName.text!]
            server6(data)
        }
    }
    @IBAction func makeDefault(_ sender: UIButton) {
        if userName.text != nil{
            let data = ["name" : Analyzer1.name!, "type": "default", "login": userName.text!]
            server6(data)
        }
    }
    @IBAction func makeNone(_ sender: UIButton) {
        if userName.text != nil{
            let data = ["name" : Analyzer1.name!, "type": "none", "login": userName.text!]
            server6(data)
        }
    }
    @IBAction func prevButton(_ sender: UIButton) {
        if Analyzer1.actionList.count-pagesIndex-8 > 0{
            pagesIndex += 8
        }
        else {
            pagesIndex += pagesIndex+8 - Analyzer1.actionList.count
        }
        actions.removeFullyAllArrangedSubviews()
        fillList()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        pagesIndex -= 8
        if pagesIndex < 0 {
            pagesIndex = 0
        }
        actions.removeFullyAllArrangedSubviews()
        fillList()
    }
    func fillList(){
        var index = 0
        let result = Analyzer1.actionList.count-8-pagesIndex
        if result > 0 {
            index = result
        }
        for x in index...Analyzer1.actionList.count-pagesIndex-1{
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = UIColor.black
            label.text = "\(Analyzer1.actionList[x].action)"
            label.font = UIFont(name: "Times New Roman", size: 20)
            actions.addArrangedSubview(label)
        }
        actions.sizeToFit()
        actions.layoutIfNeeded()
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
        if let UserVC = segue.destination as? UserViewController{
            UserVC.Analyzer1 = Analyzer1
        }
    }
    func server6 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/changeUser")!
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

extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}
