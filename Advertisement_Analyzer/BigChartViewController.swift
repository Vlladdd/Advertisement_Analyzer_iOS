//
//  BigChartViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 3/23/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import Charts
//import SwiftDataTables
import iOSDropDown

class BigChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let value : Int = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        year.optionArray = ["2020"]
        month.optionArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        week.optionArray = ["1","2","3","4","5"]
        if social == false {
            index.optionArray = ["Нових клієнтів","Проданих товарів","Прибуток"]
            source.optionArray = Analyzer1.sourcesNames
            source.optionArray.append("Порівняти")
            source.optionArray.append("Усього")
            name.isHidden = true
            nameField.isHidden = true
        }
        else {
            index.isHidden = true
            source.optionArray = ["Twitter"]
            roi.isHidden = true
            cpl.isHidden = true
            cpo.isHidden = true
            ppc.isHidden = true
            indexLabel.isHidden = true
            update.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var update: UIButton!
    
    var months = [String]()
    var days = [String]()
    var social = false
    func makeDays(){
        months = [String]()
        var startDate = 1
        for x in 1...getCountOfDays(){
            days.append(String(x))
        }
        if Int(week.text!) == 1{
            startDate = 1
        }
        if Int(week.text!) == 2{
            startDate = 8
        }
        if Int(week.text!) == 3{
            startDate = 15
        }
        if Int(week.text!) == 4{
            startDate = 22
        }
        if Int(week.text!) == 5{
            startDate = 29
        }
        for x in startDate-1...days.count-1{
            months.append(days[x])
        }
    }
    
    func getCountOfDays() -> Int{
        let dateComponents = DateComponents(year: Int(year.text!), month: Int(month.text!))
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if social == false {
            performSegue(withIdentifier: "main", sender: self)
        }
        else {
            performSegue(withIdentifier: "second", sender: self)
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if source.text != "Twitter"{
            updateData()
        }
        performSegue(withIdentifier: "bigChart2", sender: self)
    }
    
    @IBAction func update(_ sender: UIButton) {
        updateData()
        calculateIndexes()
    }
    @IBOutlet weak var year: DropDown!
    @IBOutlet weak var month: DropDown!
    @IBOutlet weak var week: DropDown!
    @IBOutlet weak var index: DropDown!
    @IBOutlet weak var source: DropDown!
    var Analyzer1 = Analyzer()
    var ProductAnalyzer1 = ProductAnalyzer()
    
    @IBOutlet weak var roi: UILabel!
    @IBOutlet weak var ppc: UILabel!
    @IBOutlet weak var cpo: UILabel!
    @IBOutlet weak var cpl: UILabel!
    func updateData(){
        Analyzer1.arrayToShow = [IndexesTotal]()
        if Int(week.text!) != nil && Int(month.text!) != nil && Int(year.text!) != nil{
            Analyzer1.makeArrayToShow(Int(week.text!)!, Int(month.text!)!, Int(year.text!)!)
            Analyzer1.makeProfitArray()
            Analyzer1.makeSalesArray()
            Analyzer1.makeClientArray()
            Analyzer1.makeMoneyWasteArray()
            Analyzer1.makeSourcesArray(Int(week.text!)!, Int(year.text!)!, Int(month.text!)!)
        }
    }
    
    func calculateIndexes() {
        var roiResult: Double = 0
        var ppcResult: Double = 0
        var cpoResult: Double = 0
        var cplResult: Double = 0
        if Analyzer1.arrayToShow.count != 0 {
            if source.text! == "Усього" || source.text! == "Порівняти" {
                roiResult = Double(Analyzer1.calculateProfit() - Analyzer1.calculateMoneyWaste())/Double(Analyzer1.calculateMoneyWaste())*100
                ppcResult = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateNewClients())))
                cpoResult = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateSales())))
                cplResult = (Double(Analyzer1.calculateProfit())/(Double(Analyzer1.calculateNewClients())))
            }
            else {
                roiResult = Double(Analyzer1.calculateSourceIndex(source.text!,"profit") - Analyzer1.calculateSourceIndex(source.text!,"moneyWaste"))/Double(Analyzer1.calculateSourceIndex(source.text!,"moneyWaste"))*100
                ppcResult = (Double(Analyzer1.calculateSourceIndex(source.text!,"moneyWaste"))/(Double(Analyzer1.calculateSourceIndex(source.text!,"newClients"))))
                cpoResult = (Double(Analyzer1.calculateSourceIndex(source.text!,"moneyWaste"))/(Double(Analyzer1.calculateSourceIndex(source.text!,"sales"))))
                cplResult = (Double(Analyzer1.calculateSourceIndex(source.text!,"profit"))/(Double(Analyzer1.calculateSourceIndex(source.text!,"newClients"))))
            }
            let ppcRounded = Double(round(100*ppcResult)/100)
            let cpoRounded = Double(round(100*cpoResult)/100)
            let cplRounded = Double(round(100*cplResult)/100)
            roi.text = "ROI: \(Int(roiResult)) %"
            ppc.text = "PPC: \(ppcRounded) $"
            cpo.text = "CPO: \(cpoRounded) $"
            cpl.text = "CPL: \(cplRounded) $"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        makeDays()
        if let BigChartMainVC = segue.destination as? BigChartMainViewController{
            if index.text == "Прибуток" {
                BigChartMainVC.value = Analyzer1.profitArray
            }
            if index.text == "Проданих товарів" {
                BigChartMainVC.value = Analyzer1.salesArray
            }
            if index.text == "Нових клієнтів" {
                BigChartMainVC.value = Analyzer1.clientsArray
            }
            BigChartMainVC.text = index.text!
            var index = ""
            if self.index.text! == "Нових клієнтів"{
                index = "newClients"
            }
            if self.index.text! == "Проданих товарів"{
                index = "sales"
            }
            if self.index.text! == "Прибуток"{
                index = "profit"
            }
            if source.text != "Усього" && source.text != "Порівняти" && source.text != "Twitter" && source.text != ""{
                BigChartMainVC.text = self.index.text! + " " + source.text!
                BigChartMainVC.value = Analyzer1.sourcesData[source.text!]![index]!
            }
            if source.text == "Порівняти" {
                BigChartMainVC.index = index
                BigChartMainVC.compare = true
            }
            if source.text == "Twitter" {
                BigChartMainVC.text = "Запитів"
                var results = [Int]()
                for x in ProductAnalyzer1.results {
                    if x.source == source.text!  && x.product == name.text && x.week == Int(week.text!) && x.year == Int(year.text!) && x.month == Int(month.text!){
                        results.append(x.result)
                    }
                }
                BigChartMainVC.value = results
            }
            BigChartMainVC.label = source.text!
            BigChartMainVC.Analyzer1 = Analyzer1
            BigChartMainVC.months = months
            BigChartMainVC.social = social
        }
        if let MainVC = segue.destination as? MainViewController{
            MainVC.Analyzer1 = Analyzer1
        }
    }
}
