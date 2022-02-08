//
//  Analyzer.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 5/29/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class Analyzer {
    
    var budget: Int!
    var currentWeek: Int!
    var week: String!
    var month: Int!
    var year: Int!
    var name: String!
    var sourceName: String!
    var startMonth: Int!
    var startWeek: Int!
    var startYear: Int!
    var startDate: Int!
    var sourceIndexes = [IndexesForSource]()
    var totalIndexes = [IndexesTotal]()
    var arrayToShow = [IndexesTotal]()
    var clientsArray = [Int]()
    var salesArray = [Int]()
    var profitArray = [Int]()
    var moneyWasteArray = [Int]()
    var sourcesNames = [String]()
    var userNames = [String]()
    var defaultUserNames = [String]()
    var roi: Int!
    var ppc: Int!
    var cpo: Int!
    var cpl: Int!
    var sourcesData = [String : [String : [Int]]]()
    var actionList = [Action]()
    var sourcesTotal = [String : [String : Int]]()
    var productNameField: String!
    var dateInDB: String!
    var sourceNameInDB: String!
    var newClientsInDB: String!
    var salesInDB: String!
    var profitInDB: String!
    var wasteInDB: String!
    var bdName: String!
    var tableName: String!
    
    init(){
        
    }
    
    init(_ actionList: [Action]){
        self.actionList = actionList
    }
    
    init(_ budget: Int, _ month: Int, _ year: Int, _ currentWeek: Int, _ week: String, _ name: String, _ sourceName: String, _ startMonth: Int, _ startYear: Int, _ startWeek: Int){
        self.week = week
        self.budget = budget
        self.currentWeek = currentWeek
        self.name = name
        self.sourceName = sourceName
        self.startMonth = startMonth
        self.startYear = startYear
        self.startWeek = startWeek
        self.month = month
        self.year = year
    }
    
    func addToSourceIndexes(_ week: Int, _ budget: Int, _ date: Int, _ year: Int, _ month: Int, _ source: String, _ newClients: Int, _ sales: Int, _ profit: Int, _ moneyWaste: Int){
        let value = IndexesForSource(week, date, year, month, source, newClients, sales, profit, moneyWaste, budget)
        sourceIndexes.append(value)
    }
    
    func calculateTotal(){
        sourceIndexes.sort{
            $0.date < $1.date
        }
        var date = sourceIndexes[0].date
        var sourceIndex = sourceIndexes[0]
        var newClients = 0
        var sales = 0
        var profit = 0
        var moneyWaste = 0
        for (id,source) in sourceIndexes.enumerated(){
            if source.date != date || id == sourceIndexes.endIndex-1{
                if id == sourceIndexes.endIndex-1 {
                    newClients += source.newClients
                    sales += source.sales
                    profit += source.profit
                    moneyWaste += source.moneyWaste
                }
                let value = IndexesTotal(sourceIndex.week, date!, sourceIndex.year, sourceIndex.month, newClients, sales, profit, moneyWaste)
                totalIndexes.append(value)
                newClients = 0
                sales = 0
                profit = 0
                moneyWaste = 0
            }
            newClients += source.newClients
            sales += source.sales
            profit += source.profit
            moneyWaste += source.moneyWaste
            date = source.date
            sourceIndex = source
        }
    }
    
    func makeArrayToShow(){
        arrayToShow = []
        for source in totalIndexes {
            if source.week == currentWeek && source.month == month && source.year == year{
                let value = IndexesTotal(source.week, source.date, source.year, source.month, source.newClients, source.sales, source.profit, source.moneyWaste)
                arrayToShow.append(value)
            }
        }
    }
    
    func makeArrayToShow(_ week: Int, _ month: Int, _ year: Int){
        arrayToShow = []
        for source in totalIndexes {
            if source.week == week && source.month == month && source.year == year{
                let value = IndexesTotal(source.week, source.date, source.year, source.month, source.newClients, source.sales, source.profit, source.moneyWaste)
                arrayToShow.append(value)
            }
        }
    }
    
    func makeClientArray(){
        clientsArray = []
        for source in arrayToShow {
            clientsArray.append(source.newClients)
        }
    }
    
    func makeSalesArray(){
        salesArray = []
        for source in arrayToShow {
            salesArray.append(source.sales)
        }
    }
    
    func makeProfitArray(){
        profitArray = []
        for source in arrayToShow {
            profitArray.append(source.profit)
        }
    }
    
    func calculateProfit() -> Int{
        var profit = 0
        for source in profitArray {
            profit += source
        }
        return profit
    }
    
    func calculateSourceIndex(_ source: String, _ index: String) -> Int{
        var indexResult = 0
        for x in sourcesData {
            if x.key == source {
                for y in x.value[index]!{
                   indexResult += y
                }
            }
        }
        return indexResult
    }
    
    func calculateSales() -> Int{
        var sales = 0
        for source in salesArray {
            sales += source
        }
        return sales
    }
    
    func calculateMoneyWaste() -> Int{
        var moneyWaste = 0
        for source in moneyWasteArray {
            moneyWaste += source
        }
        return moneyWaste
    }
    
    func calculateNewClients() -> Int{
        var newClients = 0
        for source in clientsArray {
            newClients += source
        }
        return newClients
    }
    
    func makeMoneyWasteArray(){
        moneyWasteArray = []
        for source in arrayToShow {
            moneyWasteArray.append(source.moneyWaste)
        }
    }
    
    func makeSourcesArray(_ week: Int, _ year: Int, _ month: Int){
        sourcesData.removeAll()
        sourcesNames = []
        sourceIndexes.sort{
            $0.source < $1.source
        }
        var newClients = [Int]()
        var sales = [Int]()
        var profit = [Int]()
        var moneyWaste = [Int]()
        var a = sourceIndexes[0].source
        for x in sourceIndexes{
            if a != x.source{
                sourcesNames.append(a!)
            }
            a = x.source
        }
        sourcesNames.append(a!)
        sourceIndexes.sort{
            $0.date < $1.date
        }
        for y in sourcesNames{
            for x in sourceIndexes{
                if x.source == y && x.week == week && x.year == year && x.month == month{
                    newClients.append(x.newClients)
                    sales.append(x.sales)
                    profit.append(x.profit)
                    moneyWaste.append(x.moneyWaste)
                }
            }
            sourcesData[y] = ["newClients": newClients, "sales": sales, "profit": profit, "moneyWaste": moneyWaste]
            newClients = [Int]()
            sales = [Int]()
            profit = [Int]()
            moneyWaste = [Int]()
        }
    }
    
    func addAction(_ login: String, _ date: Date, _ action: String){
        let action = Action(login, date, action)
        actionList.append(action)
    }
    
    func addAction(_ action: String){
        let action = Action(action)
        actionList.append(action)
    }
    
    func calculateSourcesTotal() {
        var totalClients = 0
        var totalSales = 0
        var totalProfit = 0
        var totalMoneyWaste = 0
        for y in sourcesNames{
            for x in sourceIndexes{
                if x.source == y{
                    totalClients += x.newClients
                    totalSales += x.sales
                    totalProfit += x.profit
                    totalMoneyWaste += x.moneyWaste
                }
            }
            sourcesTotal[y] = ["totalNewClients": totalClients, "totalSales": totalSales, "totalProfit": totalProfit, "totalMoneyWaste": totalMoneyWaste]
            totalClients = 0
            totalSales = 0
            totalProfit = 0
            totalMoneyWaste = 0
        }
    }
    
}
