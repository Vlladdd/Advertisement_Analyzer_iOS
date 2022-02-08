//
//  AboutViewController.swift
//  Advertisement_Analyzer
//
//  Created by Vlad Nechyporenko on 5/28/20.
//  Copyright © 2020 Vlad Nechyporenko. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var Analyzer1 = Analyzer()
    @IBAction func back(_ sender: UIButton) {
        performSegue(withIdentifier: "userProf", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let UserVC = segue.destination as? UserViewController{
            UserVC.Analyzer1 = Analyzer1
        }
    }

}
