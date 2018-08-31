//
//  ResultViewController.swift
//  TextbookShare
//
//  Created by 二瓶友岳 on 2018/08/30.
//  Copyright © 2018年 Nihei Tomotaka. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var selectedUniv = String()
    var selectedFac = String()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //ほぞんするために
        UserDefaults.standard.set(selectedUniv, forKey: "university")
        UserDefaults.standard.set(selectedFac, forKey: "faculty")

        resultLabel.text = selectedUniv + " " + selectedFac
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
