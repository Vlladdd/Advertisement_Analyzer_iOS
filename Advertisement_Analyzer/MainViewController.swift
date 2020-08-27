//
//  FirstViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 3/21/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import Charts
import SwiftDataTables

class MainViewController: UIViewController {
    


    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var graph: LineChartView!
    @IBOutlet weak var graph2: LineChartView!
    @IBOutlet weak var graph3: LineChartView!
    @IBOutlet weak var graph4: LineChartView!
    var months = [String]()
    var unitsSold = [Double]()
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    
    @IBAction func detail(_ sender: UIButton) {
        performSegue(withIdentifier: "bigChart", sender: self)
    }
    
    @IBAction func backFromModalMain(_ segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var currentDate: UILabel!
    var Analyzer1 = Analyzer()
    
    
    func setCurrentDate(){
        let date = Date()
        let calendar = Calendar.current
        if Analyzer1.currentWeek == 1{
            currentDate.text = "1-7.\(Analyzer1.month!).\(Analyzer1.year!)"
        }
        if Analyzer1.currentWeek == 2{
            currentDate.text = "8-14.\(Analyzer1.month!).\(Analyzer1.year!)"
        }
        if Analyzer1.currentWeek == 3{
            currentDate.text = "15-21.\(Analyzer1.month!).\(Analyzer1.year!)"
        }
        if Analyzer1.currentWeek == 4{
            currentDate.text = "22-28.\(Analyzer1.month!).\(Analyzer1.year!)"
        }
        if Analyzer1.currentWeek == 5{
            currentDate.text = "29-\(calendar.component(.day, from: date.endOfMonth)).\(Analyzer1.month!).\(Analyzer1.year!)"
        }
        startDate.text = "Дата початку: \(Analyzer1.startDate!).\(Analyzer1.startMonth!).\(Analyzer1.year!)"
    }
    var sem1 = DispatchSemaphore(value: 0)
    func addData(){
//        let y = 3
//        for x in 1...y{
//            let a = 4
//            //let b = Analyzer1.budget/y
//            let c = 22
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 22, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 23
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 23, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 24
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 24, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 25
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 25, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 26
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 26, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 27
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 27, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//        }
//        for x in 1...y{
//            let a = 4
//            let c = 28
//            let d = 2020
//            let e = 5
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(4, Analyzer1.budget/y, 28, 2020, 5, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 8
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 8, 2020, 6, "Google\(x+1)", 4+x, 5+x, 6+x, 1+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 9
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 9, 2020, 6, "Google\(x+1)", 7+x, 8+x, 9+x, 10+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 10
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 10, 2020, 6, "Google\(x+1)", 12+x, 15+x, 26+x, 21+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 11
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 11, 2020, 6, "Google\(x+1)", 24+x, 25+x, 26+x, 21+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 12
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 12, 2020, 6, "Google\(x+1)", 4+x, 5+x, 6+x, 1+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 13
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 13, 2020, 6, "Google\(x+1)", 34+x, 35+x, 36+x, 31+x)
//        }
//        for x in 1...y{
//            let a = 2
//            let c = 14
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            Analyzer1.addToSourceIndexes(2, Analyzer1.budget/y, 14, 2020, 6, "Google\(x+1)", 14+x, 15+x, 16+x, 11+x)
//        }
//        for x in 1...y{
//            for p in 15...21{
//            let a = 3
//            //let b = Analyzer1.budget/y
//            let c = p
//            let d = 2020
//            let e = 6
//            let f = "Google\(x+1)"
//            let g = Int.random(in: 0..<10)+x
//            let t = Int.random(in: 0..<10)+x
//            let o = Int.random(in: 0..<10)+x
//            let l = Int.random(in: 0..<10)+x
//            Analyzer1.addToSourceIndexes(3, Analyzer1.budget/y, p, 2020, 6, "Google\(x+1)", Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x, Int.random(in: 0..<10)+x)
//            let data = ["week" : a, "date" : c, "year" : d, "month" : e, "name" : f, "newClients" : g, "sales" : t, "profit": o, "moneyWaste" : l] as [String : Any]
//            server7(data)
//            sem1.wait()
//            }
//        }
    }
    

    
   
    @IBOutlet weak var budgetView: UIStackView!
    
    func getCurrentDate(){
        let date = Date()
        let calendar = Calendar.current
        let result = calendar.component(.day, from: date)
        Analyzer1.month = calendar.component(.month, from: date)
        Analyzer1.year = calendar.component(.year, from: date)
        if result >= 1 && result <= 7{
        Analyzer1.currentWeek = 1
        }
        if result >= 8 && result <= 14{
        Analyzer1.currentWeek = 2
        }
        if result >= 15 && result <= 21{
        Analyzer1.currentWeek = 3
        }
        if result >= 22 && result <= 28{
        Analyzer1.currentWeek = 4
        }
        if result >= 29 && result <= 31{
        Analyzer1.currentWeek = 5
        }
    }
    
    @IBOutlet weak var clientsTotal: UILabel!
    
    @IBOutlet weak var clientsAverage: UILabel!
    
    @IBOutlet weak var salesTotal: UILabel!
    
    @IBOutlet weak var salesAverage: UILabel!
    
    @IBOutlet weak var profitTotal: UILabel!
    
    @IBOutlet weak var profitAverage: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var roi: UILabel!
    
    @IBOutlet weak var ppc: UILabel!
    
    @IBOutlet weak var cpo: UILabel!
    
    @IBOutlet weak var cpl: UILabel!
    
    func calculateIndexes() {
        let roiResult: Double = Double(Analyzer1.calculateProfit() - Analyzer1.calculateMoneyWaste())/Double(Analyzer1.calculateMoneyWaste())*100
        let ppcResult: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateNewClients())))
        let cpoResult: Double = (Double(Analyzer1.calculateMoneyWaste())/(Double(Analyzer1.calculateSales())))
        let cplResult: Double = (Double(Analyzer1.calculateProfit())/(Double(Analyzer1.calculateNewClients())))
        let ppcRounded = Double(round(100*ppcResult)/100)
        let cpoRounded = Double(round(100*cpoResult)/100)
        let cplRounded = Double(round(100*cplResult)/100)
        roi.text = "ROI: \(Int(roiResult)) %"
        ppc.text = "PPC: \(ppcRounded) $"
        cpo.text = "CPO: \(cpoRounded) $"
        cpl.text = "CPL: \(cplRounded) $"
    }
    func calculateLabels(){
        var clients = 0
        var sales = 0
        var profit = 0
        var moneyWaste = 0
        for x in Analyzer1.arrayToShow{
            clients += x.newClients
            sales += x.sales
            profit += x.profit
        }
        for x in Analyzer1.totalIndexes{
            if x.year == Analyzer1.startYear {
                if x.month == Analyzer1.startMonth{
                    if x.week >= Analyzer1.startWeek{
                        moneyWaste += x.moneyWaste
                    }
                }
                if x.month > Analyzer1.startMonth
                {
                    moneyWaste += x.moneyWaste
                }
            }
            if x.year > Analyzer1.startYear {
                moneyWaste += x.moneyWaste
            }
        }
        clientsTotal.text = "Всього за період: \(clients)"
        clientsAverage.text = "В середньому за день: \(clients/Analyzer1.arrayToShow.count)"
        salesTotal.text = "Всього за період: \(sales)"
        salesAverage.text = "В середньому за день: \(sales/Analyzer1.arrayToShow.count)"
        profitTotal.text = "Всього за період: \(profit)"
        profitAverage.text = "В середньому за день: \(profit/Analyzer1.arrayToShow.count)"
        budgetLabel.text = "Бюджет: \(Analyzer1.budget - moneyWaste)$"
    }
    var User1 = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        //addData()
       // let data = ["name" : "mongodb://Vlladdd:vladvlad1@ds211168.mlab.com:11168/test_for_analyzer", "dbname" : "test_for_analyzer", "collection" : "test"]
        let data = ["name" : Analyzer1.sourceName!, "dbname" : Analyzer1.bdName!, "collection" : Analyzer1.tableName!]
        server8(data)
        sem1.wait()
        addLabelsToBudgetView()
        getCurrentDate()
        makeDays()
        setCurrentDate()
        Analyzer1.calculateTotal()
        Analyzer1.makeArrayToShow()
        calculateLabels()
        Analyzer1.makeClientArray()
        Analyzer1.makeSalesArray()
        Analyzer1.makeProfitArray()
        Analyzer1.makeMoneyWasteArray()
        Analyzer1.makeSourcesArray(Analyzer1.currentWeek, Analyzer1.year, Analyzer1.month)
        setMultipleChart()
        calculateIndexes()
//        Analyzer1.startMonth = 5
//        Analyzer1.startYear = 2020
//        Analyzer1.startWeek = 4
        setChart(dataEntryY: Analyzer1.clientsArray,"Нових клієнтів",1)
        setChart(dataEntryY: Analyzer1.salesArray,"Проданих товарів",2)
        setChart(dataEntryY: Analyzer1.profitArray,"Прибуток",3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var Analyzer2 = Analyzer()
        if let tbc = tabBarController as? TabBarViewController {
            Analyzer2 = tbc.Analyzer1
            User1 = tbc.User1
        }
        Analyzer1.actionList = Analyzer2.actionList
        Analyzer1.addAction(User1.login, Date(), "Перейшов на сторінку аналізу рекламної кампанії")
        updateList()
    }
    
    func updateList() {
        var actions = [String]()
        for x in Analyzer1.actionList{
            actions.append(x.action)
        }
        let data2 = ["name" : Analyzer1.name! , "actions" : actions] as [String : Any]
        server6(data2)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            tbc.Analyzer1 = Analyzer1
        }
    }
    
    var days = [String]()
    
    func getCountOfDays() -> Int{
        let dateComponents = DateComponents(year: Analyzer1.year, month: Analyzer1.month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }


    func addLabelsToBudgetView() {
        Analyzer1.sourceIndexes.sort{
            $0.source < $1.source
        }
        var a = Analyzer1.sourceIndexes[0].source
        var b = Analyzer1.sourceIndexes[0]
        var moneyWaste = 0
        for (id,x) in Analyzer1.sourceIndexes.enumerated(){
            if x.source != a || id == Analyzer1.sourceIndexes.endIndex-1{
                if id == Analyzer1.sourceIndexes.endIndex-1 {
                    moneyWaste += x.moneyWaste
                }
                let label = UILabel()
                label.textColor = UIColor.black
                label.text = "\(a!): \(b.budget - moneyWaste)$"
                label.font = UIFont(name: "Times New Roman", size: 20)
                budgetView.addArrangedSubview(label)
                moneyWaste = 0
            }
            if x.year == Analyzer1.startYear {
                if x.month == Analyzer1.startMonth{
                    if x.week >= Analyzer1.startWeek{
                        moneyWaste += x.moneyWaste
                    }
                }
                if x.month > Analyzer1.startMonth
                {
                    moneyWaste += x.moneyWaste
                }
            }
            if x.year > Analyzer1.startYear {
                moneyWaste += x.moneyWaste
            }
            a = x.source
            b = x
        }
        budgetView.sizeToFit()
        budgetView.layoutIfNeeded()
    }
    
    func makeDays(){
        var startDate = 1
        for x in 1...getCountOfDays(){
            days.append(String(x))
        }
        if Analyzer1.currentWeek == 1{
            startDate = 1
        }
        if Analyzer1.currentWeek == 2{
            startDate = 8
        }
        if Analyzer1.currentWeek == 3{
            startDate = 15
        }
        if Analyzer1.currentWeek == 4{
            startDate = 22
        }
        if Analyzer1.currentWeek == 5{
            startDate = 29
        }
        for x in startDate-1...days.count-1{
            months.append(days[x])
        }
       // print(months)
    }
    
    func setChart(dataEntryY forY: [Int],_ label: String,_ currentGraph: Int) {
        axisFormatDelegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<forY.count{
            // print(forX[i])
            // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(forY[i]) , data: months as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: label)
        let chartData = LineChartData(dataSet: chartDataSet)
        var xAxisValue = graph.xAxis
        var yAxisValue = graph.leftAxis
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        fmt.groupingSeparator = ","
        fmt.decimalSeparator = "."
        if currentGraph == 1{
            graph.data = chartData
            graph.translatesAutoresizingMaskIntoConstraints = false
            graph.noDataText = "Немає даних"
            xAxisValue = graph.xAxis
            yAxisValue = graph.leftAxis
        }
        if currentGraph == 2{
            graph2.data = chartData
            graph2.translatesAutoresizingMaskIntoConstraints = false
            graph2.noDataText = "Немає даних"
            xAxisValue = graph2.xAxis
            yAxisValue = graph2.leftAxis
        }
        if currentGraph == 3{
            graph3.data = chartData
            graph3.translatesAutoresizingMaskIntoConstraints = false
            graph3.noDataText = "Немає даних"
            xAxisValue = graph3.xAxis
            yAxisValue = graph3.leftAxis
        }
        yAxisValue.valueFormatter = DefaultAxisValueFormatter.init(formatter: fmt)
        xAxisValue.valueFormatter = axisFormatDelegate
        xAxisValue.labelCount = forY.count-1
        
    }
    
    func setDataEntry(_ values: [String:[Int]]) -> LineChartData{
        var circleColors: [NSUIColor] = []
        axisFormatDelegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        var dataEntries:[ChartDataEntry] = []
        let data = LineChartData()
        for x in values{
            for i in 0..<x.value.count{
                // print(forX[i])
                //let dataEntry = BarChartDataEntry(x: (months[i] as NSString).doubleValue, y: Double(x.value[i]))
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(x.value[i]) , data: months as AnyObject?)
                dataEntries.append(dataEntry)
            }
            let red   = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue  = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            circleColors.append(color)
            let chartDataSet = LineChartDataSet(entries: dataEntries, label: x.key)
            chartDataSet.colors = circleColors
            chartDataSet.drawCirclesEnabled = false
            chartDataSet.drawValuesEnabled = false
            data.addDataSet(chartDataSet)
            dataEntries = []
            circleColors = []
        }
        return data
    }

    func setMultipleChart() {
        graph4.noDataText = "Немає даних"
        var values = [String:[Int]]()
        for x in Analyzer1.sourcesData{
            values[x.key] = x.value["profit"]
        }
        var data = LineChartData()
        data = setDataEntry(values)
        graph4.data = data
        let xAxisValue = graph4.xAxis
        let yAxisValue = graph4.leftAxis
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        fmt.groupingSeparator = ","
        fmt.decimalSeparator = "."
        yAxisValue.valueFormatter = DefaultAxisValueFormatter.init(formatter: fmt)
        xAxisValue.valueFormatter = axisFormatDelegate
        xAxisValue.labelCount = values["Google2"]!.count-1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let BigChartVC = segue.destination as? BigChartViewController{
            BigChartVC.Analyzer1 = Analyzer1
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
        let url = URL(string: "http://localhost:3000/addData")!
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
            self.sem1.signal()
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func server8 (_ dataDictionary: [String : Any]) {
        let url = URL(string: "http://localhost:3000/findData")!
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
                if let array = json as? [[String : Any]] {
                    // print(json)
                    for k in array {
                        let month = k["month"] as? Int
                        let date = k["date"] as? Int
                        let newClients = k[self.Analyzer1.newClientsInDB] as? Int
                        let moneyWaste = k[self.Analyzer1.wasteInDB] as? Int
                        let name = k[self.Analyzer1.sourceNameInDB] as? String
                        let profit = k[self.Analyzer1.profitInDB] as? Int
                        let year = k["year"] as? Int
                        let sales = k[self.Analyzer1.salesInDB] as? Int
                        let week = k["week"] as? Int
                        self.Analyzer1.addToSourceIndexes(week!, self.Analyzer1.budget/3, date!, year!, month!, name!, newClients!, sales!, profit!, moneyWaste!)
                    }
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
extension MainViewController: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value)]
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
}



