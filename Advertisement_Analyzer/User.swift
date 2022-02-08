//
//  User.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 6/7/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import Foundation

class User{
    var login = ""
    var password = ""
    var dateOfBirth = ""
    var company = ""
    var name = ""
    var role = "Admin"
    
    init(_ login: String, _ password: String){
        self.login = login
        for _ in password {
            self.password.append("*")
        }
    }
    
    init(){
        
    }
    
    func updateUser(_ login: String, _ password: String, _ dateOfBirth: String, _ company: String, _ name: String!){
        if login.count > 0 {
            self.login = login
        }
        if password.count > 0 {
            self.password = ""
            for _ in password {
                self.password.append("*")
            }
        }
        if dateOfBirth.count > 0 {
            self.dateOfBirth = dateOfBirth
        }
        if company.count > 0 {
            self.company = company
        }
        if name.count > 0 {
            self.name = name
        }
    }
}
