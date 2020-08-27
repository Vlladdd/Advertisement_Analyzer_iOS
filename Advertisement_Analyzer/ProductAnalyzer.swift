//
//  ProductAnalyzer.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechiporenko on 6/6/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class ProductAnalyzer{
    var currentWeek: Int!
    var month: Int!
    var year: Int!
    var results = [ProductAnalyzerResult]()
    
    init(_ week: Int, _ month: Int, _ year: Int){
        self.currentWeek = week
        self.month = month
        self.year = year
    }
    
    init(){
        
    }
    
    func addResult(_ source: String, _ product: String, _ week: Int, _ year: Int, _ month: Int, _ result: Int){
        let result = ProductAnalyzerResult(source, product, week, year, month, result)
        results.append(result)
    }
}

