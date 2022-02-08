//
//  BigChartMainViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 5/29/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit
import Charts
//import SwiftDataTables

class BigChartMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let value : Int = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        if compare == false{
            setChart()
        }
        else {
            setMultipleChart()
        }
        info.text = text

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "bigChart", sender: self)
    }
    
    @IBOutlet weak var info: UILabel!
    var Analyzer1 = Analyzer()
    var text = ""
    var compare = false
    var value = [Int]()
    var label = "da"
    var index = ""
    var social = true
    @IBOutlet weak var graph: LineChartView!
    var months = ["1","2","3","4","5","6","7"]
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    func setChart() {
        axisFormatDelegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        var dataEntries:[ChartDataEntry] = []
        if value.count > 0 {
            for i in 0..<value.count{
                // print(forX[i])
                // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(value[i]) , data: months as AnyObject?)
                dataEntries.append(dataEntry)
            }
            let chartDataSet = LineChartDataSet(entries: dataEntries, label: label)
            let chartData = LineChartData(dataSet: chartDataSet)
            graph.data = chartData
        }
        let xAxisValue = graph.xAxis
        let yAxisValue = graph.leftAxis
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        fmt.groupingSeparator = ","
        fmt.decimalSeparator = "."
        graph.translatesAutoresizingMaskIntoConstraints = false
        graph.noDataText = "Немає даних"
        yAxisValue.valueFormatter = DefaultAxisValueFormatter.init(formatter: fmt)
        xAxisValue.valueFormatter = axisFormatDelegate
        xAxisValue.labelCount = value.count-1
        
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
        graph.noDataText = "Немає даних"
        var values = [String:[Int]]()
        print(index)
        print(Analyzer1.sourcesData)
        for x in Analyzer1.sourcesData{
            values[x.key] = x.value[index]
        }
        print(values)
        var data = LineChartData()
        data = setDataEntry(values)
        graph.data = data
        let xAxisValue = graph.xAxis
        let yAxisValue = graph.leftAxis
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
            BigChartVC.social = social
        }
    }

}

extension BigChartMainViewController: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value)]
    }
}
