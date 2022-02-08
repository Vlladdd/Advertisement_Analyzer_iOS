//
//  IndexesForAnalyze.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 5/29/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

struct IndexesForSource {
      
    var week: Int!
    var date: Int!
    var year: Int!
    var month: Int!
    var source: String!
    var budget: Int!
    var newClients: Int!
    var sales: Int!
    var profit: Int!
    var moneyWaste: Int!
    
    init(_ week: Int, _ date: Int, _ year: Int, _ month: Int, _ source: String, _ newClients: Int, _ sales: Int, _ profit: Int, _ moneyWaste: Int, _ budget: Int){
        self.week = week
        self.date = date
        self.year = year
        self.month = month
        self.source = source
        self.newClients = newClients
        self.sales = sales
        self.profit = profit
        self.moneyWaste = moneyWaste
        self.budget = budget
    }
}
