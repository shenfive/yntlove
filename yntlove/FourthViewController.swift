//
//  FourthViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var divLine: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarItem.selectedImage = UIImage(named: "icon_tree_h")
        let backLine = UIImage(named: "line_shadow")
        divLine.backgroundColor = UIColor(patternImage: backLine!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
