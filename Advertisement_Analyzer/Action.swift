//
//  Action.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 6/4/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation


struct Action {
    var action = ""
    
    init(_ login: String, _ date: Date, _ action: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let someDateTime = formatter.string(from: date)
        self.action = "\(someDateTime) \(login) \(action)"
    }
    
    init(_ action: String){
        self.action = action
    }
}
