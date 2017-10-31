//
//  ViewController.swift
//  AddressSelectView-Swfit
//
//  Created by 程健 on 2017/10/31.
//  Copyright © 2017年 程健. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var button : UIButton?
    
    var model1 : AddressModel?
    var model2 : AddressModel?
    var model3 : AddressModel?
    
    @IBAction func click() {

        AddressSelectView.show(withProvince: model1?.region_id, city: model2?.region_id, district: model3?.region_id) { (province , city, district) in
            self.button?.setTitle("\(province.region_name!)  \(city.region_name!)  \(district.region_name!)", for: .normal)
            self.model1 = province
            self.model2 = city
            self.model3 = district
        }
    }
}

