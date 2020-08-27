//
//  SecondViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 3/21/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import Charts
import SwiftDataTables
import iOSDropDown

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        graph.noDataText = "Немає даних"
        source.optionArray = ["Google"]
        // Do any additional setup after loading the view.
    }
    
    var Analyzer1 = Analyzer()
    
    func updateList() {
        var actions = [String]()
        for x in Analyzer1.actionList{
            actions.append(x.action)
        }
        let data2 = ["name" : Analyzer1.name! , "actions" : actions] as [String : Any]
        server6(data2)
    }
    @IBOutlet weak var graph: LineChartView!
    var User1 = User()
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: DropDown!
    @IBOutlet weak var name: UITextField!
    override func viewDidAppear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            Analyzer1 = tbc.Analyzer1
            User1 = tbc.User1
        }
        Analyzer1.addAction(User1.login, Date(), "Перейшов на сторінку аналізу рекламної продукції")
        ProductAnalyzer1.currentWeek = Analyzer1.currentWeek
        ProductAnalyzer1.month = Analyzer1.month
        ProductAnalyzer1.year = Analyzer1.year
        setCurrentDate()
        updateList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tbc = tabBarController as? TabBarViewController {
            tbc.Analyzer1 = Analyzer1
        }
    }
    var ProductAnalyzer1 = ProductAnalyzer()
    var sem1 = DispatchSemaphore(value: 0)
    var months = ["1","2","3","4","5","6","7"]
    var value = [Int]()
    var days = [String]()
    weak var axisFormatDelegate: IAxisValueFormatter?
    @IBAction func detail(_ sender: UIButton) {
        performSegue(withIdentifier: "bigChart", sender: self)
    }
    var results = [Int]()
    @IBAction func update(_ sender: UIButton) {
        makeDays()
        var results = [Int]()
        let data = ["name": name.text!]
        server7(data)
        sem1.wait()
        for x in ProductAnalyzer1.results {
            if x.source == source.text! && x.product == name.text! && x.week == 1 && x.year == ProductAnalyzer1.year && x.month == ProductAnalyzer1.month{
                results.append(x.result)
            }
        }
        value = results
        setChart()
    }
    
    func setChart() {
        axisFormatDelegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<value.count{
            // print(forX[i])
            // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(value[i]) , data: months as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Google")
        let chartData = LineChartData(dataSet: chartDataSet)
        let xAxisValue = graph.xAxis
        let yAxisValue = graph.leftAxis
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        fmt.groupingSeparator = ","
        fmt.decimalSeparator = "."
        graph.data = chartData
        graph.translatesAutoresizingMaskIntoConstraints = false
        graph.noDataText = "Немає даних"
        yAxisValue.valueFormatter = DefaultAxisValueFormatter.init(formatter: fmt)
        xAxisValue.valueFormatter = axisFormatDelegate
        xAxisValue.labelCount = value.count-1
        
    }
    
    func makeDays(){
        months = [String]()
        var startDate = 1
        for x in 1...getCountOfDays(){
            days.append(String(x))
        }
        if ProductAnalyzer1.currentWeek == 1{
            startDate = 1
        }
        if ProductAnalyzer1.currentWeek == 2{
            startDate = 8
        }
        if ProductAnalyzer1.currentWeek == 3{
            startDate = 15
        }
        if ProductAnalyzer1.currentWeek == 4{
            startDate = 22
        }
        if ProductAnalyzer1.currentWeek == 5{
            startDate = 29
        }
        for x in startDate-1...days.count-1{
            months.append(days[x])
        }
    }
    
    @IBOutlet weak var currentDate: UILabel!
    func getCountOfDays() -> Int{
        let dateComponents = DateComponents(year: ProductAnalyzer1.year, month: ProductAnalyzer1.month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let BigChartVC = segue.destination as? BigChartViewController{
            BigChartVC.Analyzer1 = Analyzer1
            BigChartVC.ProductAnalyzer1 = ProductAnalyzer1
            BigChartVC.social = true
        }
    }
    
    @IBAction func backFromModalSecond(_ segue: UIStoryboardSegue) {
     }
    
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
        let url = URL(string: "http://localhost:3000/findProduct")!
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
                        let name = k["name"] as? String
                        let product = k["product"] as? String
                        let year = k["year"] as? Int
                        let result = k["results"] as? Int
                        var week = 1
                        if date! > 0 && date! < 8 {
                            week = 1
                        }
                        if date! > 7 && date! < 14 {
                            week = 2
                        }
                        if date! > 13 && date! < 21 {
                            week = 3
                        }
                        if date! > 20 && date! < 28 {
                            week = 4
                        }
                        if date! > 27 && date! < 32 {
                            week = 5
                        }
                        self.ProductAnalyzer1.addResult(name!, product!, week, year!, month!, result!)
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

extension SecondViewController: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value)]
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

