//
//  SelectFacViewController.swift
//  TextbookShare
//
//  Created by 二瓶友岳 on 2018/08/30.
//  Copyright © 2018年 Nihei Tomotaka. All rights reserved.
//

import UIKit

class SelectFacViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var selectedRow = 0
    var selectedUniv = String()
    var facs = [String]()
    
    @IBOutlet weak var univLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        univLabel.text = selectedUniv
        
        facs = [
            "人文学部",
            "理工学部",
            "医学部",
            "社会学部",
            "農学部"
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return facs.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return facs[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        selectedRow = row
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let dest = segue.destination.childViewControllers[0] as! ResultViewController
            dest.selectedFac = facs[selectedRow]
            dest.selectedUniv = selectedUniv
        }
    }

}
