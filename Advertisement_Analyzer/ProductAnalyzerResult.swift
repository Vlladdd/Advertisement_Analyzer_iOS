//
//  ProductAnalyzerResult.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 6/6/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

struct ProductAnalyzerResult{
    
    var source: String!
    var product: String!
    var week: Int!
    var year: Int!
    var month: Int!
    var date: Int!
    var result: Int!
    
    init(_ source: String, _ product: String, _ week: Int, _ year: Int, _ month: Int, _ result: Int){
        self.source = source
        self.product = product
        self.week = week
        self.year = year
        self.month = month
        self.result = result
    }
}
