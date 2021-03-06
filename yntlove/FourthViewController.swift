//
//  FourthViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var pictures: UITableView!
    var images = [UIImage]()
    
    @IBOutlet weak var divLine: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBarItem.selectedImage = UIImage(named: "icon_tree_h")
        let backLine = UIImage(named: "line_shadow")
        divLine.backgroundColor = UIColor(patternImage: backLine!)
        
        for i in 1...6{
            images.append(UIImage(named: "p10\(i)")!)
        }
        pictures.delegate = self
        pictures.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let imageView = UIImageView(image: images[indexPath.row])
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 20, y: 0, width: 230, height: 200)
        imageView.contentMode = .scaleAspectFill
        cell.backgroundColor = UIColor.clear
        cell.addSubview(imageView)
        
        return cell
    }
    
}
