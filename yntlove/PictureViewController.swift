//
//  PictureViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/10.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var divLine: UIView!
    
    @IBOutlet weak var pictureTable: UITableView!
    var pictures = [UIImage]()
    var theTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let backLine = UIImage(named: "line_shadow")
        divLine.backgroundColor = UIColor(patternImage: backLine!)
        pictureTable.delegate = self
        pictureTable.dataSource = self
        subTitle.text = theTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let imageView = UIImageView(image: pictures[indexPath.row])
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 20, y: 0, width: 230, height: 200)
        imageView.contentMode = .scaleAspectFill
        cell.backgroundColor = UIColor.clear
        cell.addSubview(imageView)
        
        return cell
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
