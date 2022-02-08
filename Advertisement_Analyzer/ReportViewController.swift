//
//  ReportViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 6/4/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var Analyzer1 = Analyzer()
    var User1 = User()
    var bestName = ""
    var worstName = ""
    override func viewDidAppear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            Analyzer1 = tbc.Analyzer1
            User1 = tbc.User1
        }
        Analyzer1.addAction(User1.login, Date(), "Перейшов на сторінку завершення аналізу рекламної продукції")
        updateList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            tbc.Analyzer1 = Analyzer1
        }
    }

    @IBAction func endButton(_ sender: UIButton) {
        setSources()
        calculateIndexes()
        let data = ["name" : Analyzer1.name! , "startWeek": Analyzer1.startWeek!, "startYear": Analyzer1.startYear!, "startMonth": Analyzer1.startMonth!, "currentWeek": Analyzer1.currentWeek!, "currentMonth": Analyzer1.month!, "currentYear": Analyzer1.year!, "bestSource": bestName, "worstSource": worstName, "roi" : roi.text! , "ppc": ppc.text!, "cpl" : cpl.text! , "cpo" : cpo.text!] as [String : Any]
        server7(data)
    }
    
    func updateList() {
        var actions = [String]()
        for x in Analyzer1.actionList{
            actions.append(x.action)
        }
        let data2 = ["name" : Analyzer1.name! , "actions" : actions] as [String : Any]
        server6(data2)
    }
    
    @IBOutlet weak var bestSource: UILabel!
    @IBOutlet weak var worstSource: UILabel!
    @IBOutlet weak var roi: UILabel!
    @IBOutlet weak var ppc: UILabel!
    @IBOutlet weak var cpo: UILabel!
    @IBOutlet weak var cpl: UILabel!
    
    func setSources(){
        Analyzer1.calculateSourcesTotal()
        var bestResult = Array(Analyzer1.sourcesTotal)[0].value["totalProfit"]! - Array(Analyzer1.sourcesTotal)[0].value["totalMoneyWaste"]!
        bestName = Array(Analyzer1.sourcesTotal)[0].key
        var worstResult = Array(Analyzer1.sourcesTotal)[0].value["totalProfit"]! - Array(Analyzer1.sourcesTotal)[0].value["totalMoneyWaste"]!
        worstName = Array(Analyzer1.sourcesTotal)[0].key
        for x in Analyzer1.sourcesTotal {
            if (x.value["totalProfit"]! - x.value["totalMoneyWaste"]!) > bestResult {
                bestResult = x.value["totalProfit"]! - x.value["totalMoneyWaste"]!
                bestName = x.key
            }
            if (x.value["totalProfit"]! - x.value["totalMoneyWaste"]!) < worstResult {
                worstResult = x.value["totalProfit"]! - x.value["totalMoneyWaste"]!
                worstName = x.key
            }
//            if (x.value["totalProfit"]! - x.value["totalMoneyWaste"]!) == bestResult {
//                if bestName != x.key{
//                    bestName += ","
//                    bestName += x.key
//                }
//            }
//            if (x.value["totalProfit"]! - x.value["totalMoneyWaste"]!) == worstResult {
//                if worstName != x.key{
//                    worstName += ","
//                    worstName += x.key
//                }
//            }
        }
        bestSource.text = bestName
        worstSource.text = worstName
        bestSource.isHidden = false
        worstSource.isHidden = false
    }
    
    func calculateIndexes() {
        Analyzer1.makeArrayToShow()
        Analyzer1.makeClientArray()
        Analyzer1.makeSalesArray()
        Analyzer1.makeProfitArray()
        Analyzer1.makeMoneyWasteArray()
        let roi1: Double = Double(Analyzer1.calculateProfit() - Analyzer1.calculateMoneyWaste())/Double(Analyzer1.calculateMoneyWaste())*100
        let ppc1: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateNewClients())))
        let cpo1: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateSales())))
        let cpl1: Double = (Double(Analyzer1.calculateProfit())/(Double(Analyzer1.calculateNewClients())))
        Analyzer1.makeArrayToShow(Analyzer1.startWeek, Analyzer1.startMonth, Analyzer1.startYear)
        Analyzer1.makeClientArray()
        Analyzer1.makeSalesArray()
        Analyzer1.makeProfitArray()
        Analyzer1.makeMoneyWasteArray()
        let roi2: Double = Double(Analyzer1.calculateProfit() - Analyzer1.calculateMoneyWaste())/Double(Analyzer1.calculateMoneyWaste())*100
        let ppc2: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateNewClients())))
        let cpo2: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateSales())))
        let cpl2: Double = (Double(Analyzer1.calculateProfit())/(Double(Analyzer1.calculateNewClients())))
        let roiResult = roi1 - roi2
        let ppcResult = ppc1 - ppc2
        let cpoResult = cpo1 - cpo2
        let cplResult = cpl1 - cpl2
        let ppcRounded = Double(round(100*ppcResult)/100)
        let cpoRounded = Double(round(100*cpoResult)/100)
        let cplRounded = Double(round(100*cplResult)/100)
        if roiResult > 0 {
            roi.text = "ROI: +\(Int(roiResult)) %"
        }
        else {
            roi.text = "ROI: \(Int(roiResult)) %"
        }
        if ppcRounded > 0 {
            ppc.text = "PPC: +\(ppcRounded) $"
        }
        else {
            ppc.text = "PPC: \(ppcRounded) $"
        }
        if cpoRounded > 0 {
            cpo.text = "CPO: +\(cpoRounded) $"
        }
        else {
            cpo.text = "CPO: \(cpoRounded) $"
        }
        if cplRounded > 0 {
            cpl.text = "CPL: +\(cplRounded) $"
        }
        else {
            cpl.text = "CPL: \(cplRounded) $"
        }
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
    
    func server7 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/report")!
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


}
