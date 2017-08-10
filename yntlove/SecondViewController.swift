//
//  SecondViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var contentView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarItem.selectedImage = UIImage(named: "icon_phone_h")
        
        let content = CominiView(frame: CGRect(x: 0, y: 0, width: 248, height: 386))
        content.hostVC = self
        contentView.contentSize = content.bounds.size        
        contentView.addSubview(content)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

