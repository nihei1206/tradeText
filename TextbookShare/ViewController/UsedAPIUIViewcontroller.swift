//
//  UsedAPIUIViewcontroller.swift
//  TextbookShare
//
//  Created by 二瓶友岳 on 2018/08/31.
//  Copyright © 2018年 Nihei Tomotaka. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class UsedAPIUIViewController: UIViewController {
    
    var isbn = String()
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var sTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)"
        
        Alamofire.request(api).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    print(json)
                    
                    let imageUrlStr = json["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                    
                    let httpsUrlStr = imageUrlStr.replacingOccurrences(of:"http://", with:"https://")
                    
                    if let url = URL(string: httpsUrlStr) {
                        
                        self.bookImageView.af_setImage(withURL: url)
                    }
                    
                    let title = json["items"][0]["volumeInfo"]["title"].stringValue
                    
                    let sTitle = json["items"][0]["volumeInfo"]["subtitle"].stringValue
                    let desc = json["items"][0]["volumeInfo"]["description"].stringValue
                    
                    self.bookTitleLabel.text = title
                    self.sTitleLabel.text = sTitle
                    self.descriptionTextView.text = desc

                }
            case .failure(let error):
                self.bookTitleLabel.text = "エラーが発生しました"
                self.descriptionTextView.text = error.localizedDescription
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
