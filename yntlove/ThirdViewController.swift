//
//  ThirdViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var rightTopTabUnderLine: UIView!
    @IBOutlet weak var rightTopTabButton: UIButton!
    @IBOutlet weak var leftTopTabUnderLine: UIView!
    @IBOutlet weak var leftTopTabButton: UIButton!
    @IBOutlet weak var contentView: UIScrollView!
    
    let unSelectedColor = UIColor(red: 170/255, green: 165/255, blue: 156/255, alpha: 1)
    let seletecdColor = UIColor(red: 254/255, green: 189/255, blue: 92/255, alpha: 1)
    let content1 = Area1Traffic(frame: CGRect(x: 0, y: 0, width: 249, height: 660))
    let content2 = Area2Traffic(frame: CGRect(x: 0, y: 0, width: 249, height: 1101))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarItem.selectedImage = UIImage(named: "icon_car_h")
        rightTopTabUnderLine.backgroundColor = unSelectedColor
        rightTopTabButton.setTitleColor(unSelectedColor, for: .normal)
  
        contentView.contentSize = CGSize(width: 249, height: 660)
        content1.hostVC = self
        content2.hostVC = self
        contentView.addSubview(content1)
        contentView.addSubview(content2)
        content2.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setArea1(_ sender: Any) {
        rightTopTabUnderLine.backgroundColor = unSelectedColor
        rightTopTabButton.setTitleColor(unSelectedColor, for: .normal)
        leftTopTabUnderLine.backgroundColor = seletecdColor
        leftTopTabButton.setTitleColor(seletecdColor, for: .normal)
        contentView.contentSize = CGSize(width: 249, height: 660)
        content1.isHidden = false
        content2.isHidden = true
        
    }

   
    @IBAction func setArea2(_ sender: Any) {
        leftTopTabUnderLine.backgroundColor = unSelectedColor
        leftTopTabButton.setTitleColor(unSelectedColor, for: .normal)
        rightTopTabUnderLine.backgroundColor = seletecdColor
        rightTopTabButton.setTitleColor(seletecdColor, for: .normal)
        contentView.contentSize = CGSize(width: 249, height: 1101)
        content1.isHidden = true
        content2.isHidden = false
    }
    

}
