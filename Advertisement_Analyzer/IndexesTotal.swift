//
//  IndexesTotal.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 5/29/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

struct IndexesTotal {
    
    var week: Int!
    var date: Int!
    var year: Int!
    var month: Int!
    var newClients: Int!
    var sales: Int!
    var profit: Int!
    var moneyWaste: Int!
    
    init(_ week: Int, _ date: Int, _ year: Int, _ month: Int, _ newClients: Int, _ sales: Int, _ profit: Int, _ moneyWaste: Int!){
        self.week = week
        self.date = date
        self.year = year
        self.month = month
        self.newClients = newClients
        self.sales = sales
        self.profit = profit
        self.moneyWaste = moneyWaste
    }
}
