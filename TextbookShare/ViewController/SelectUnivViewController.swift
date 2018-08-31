//
//  ViewController.swift
//  TextbookShare
//
//  Created by 二瓶友岳 on 2018/08/30.
//  Copyright © 2018年 Nihei Tomotaka. All rights reserved.
//

import UIKit

class SelectUnivViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var selectPickerView: UIPickerView!
    
    var univs = [String]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPickerView.delegate = self
        selectPickerView.dataSource = self
        
        univs = ["北海道大学","弘前大学", "岩手大学", "秋田大学", "東北大学", "山形大学","福島大学","宇都宮大学","茨城大学","群馬大学","埼玉大学","東京大学","都立首都大学","東京外国語大学","東京農大","早稲田大学","慶應大学","京都大学","岡山大学","広島大学","近畿大学","愛媛大学","愛知大学","高知大学","香川大学","島根大学","山口大学","大阪大学","九州大学","琉球大学"]
        
        
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
        return univs.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return univs[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        selectedRow = row
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let dest = segue.destination as! SelectFacViewController
            dest.selectedUniv = univs[selectedRow]
        }
    }

}

