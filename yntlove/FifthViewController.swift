//
//  FifthViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit
import WebKit



class FifthViewController: UIViewController {

  
    @IBOutlet weak var divLine: UIView!
    
    var netWorkStatusTimer = Timer()
    var testCount = 0
    let mainThread = Thread.main
    let webView = WKWebView()
    let button = UIButton()
    let theServer = "https://f5f.yntlove.com/"
    
    var picturesA = [UIImage]()
    var picturesB = [UIImage]()
    var picturesC = [UIImage]()
    var targetPictures = [UIImage]()
    var picturesSubTitle = ""


    @IBOutlet weak var pictures: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.selectedImage = UIImage(named: "icon_photo_h")
        self.tabBarItem.selectedImage = UIImage(named: "icon_tree_h")
        let backLine = UIImage(named: "line_shadow")
        divLine.backgroundColor = UIColor(patternImage: backLine!)
        netWork()
        
        for i in 1...9 {picturesA.append(UIImage(named:"pa0\(i)")!)}
        for i in 10...14{picturesA.append(UIImage(named:"pa\(i)")!)}
        for i in 1...6{picturesB.append(UIImage(named:"pb0\(i)")!)}
        for i in 1...5{picturesC.append(UIImage(named:"pc0\(i)")!)}
        
        
        // Do any additional setup after loading the view.
        pictures.isHidden = true
        let rect = CGRect(x: self.view.frame.origin.x,
                          y: self.view.frame.origin.y + 20,
                          width: self.view.frame.width,
                          height: self.view.frame.height + 120)
        webView.frame = rect
        webView.isHidden = true
        button.frame = CGRect(x: 0, y: 20, width: 66, height: 33)
        button.setImage(UIImage(named:"icon_back"), for: .normal)
        button.setTitle("", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(self.hindWeb), for: .touchUpInside)
      
        
        self.view.addSubview(webView)
        self.view.addSubview(button)
        
    }
    
    func hindWeb(){
        self.button.isHidden = true
        self.webView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        netWorkStatusTimer = Timer.scheduledTimer(timeInterval: 6 , target: self, selector: #selector(self.netWork), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        netWorkStatusTimer.invalidate()
    }
    
    // 測目標網址是否存在
    func netWork(){
//        return
        print(self.pictures.isHidden)
        let reachablility = Reachability(hostName: "www.apple.com")
        if reachablility?.currentReachabilityStatus().rawValue != 0 {
            print("網路通的")
            let urlString = self.theServer + "mobile/in"
            let url = URL(string: urlString)
            let urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.9)
            let session = URLSession.shared
            session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error == nil{
                    if ((response as! HTTPURLResponse).statusCode) == 200 {

                        if let contentString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?{
                            if contentString == "in"{
                                
//                                self.pictures.isHidden = false
                                DispatchQueue.main.async {
                                    self.pictures.isHidden = false
                                    
                                }

                            }else{self.hindPicture()}
                        }else{self.hindPicture()}
                    }else{self.hindPicture()}
                }else{self.hindPicture()}
            }).resume()
        }else{hindPicture()}
    }
    
    @IBAction func openPictureWeb(_ sender: UIButton) {
        webView.isHidden = false
        button.isHidden = false
        if webView.isLoading == false{
            let urlRequest = URLRequest(url: URL(string:theServer + "MUser/login")!)
            webView.load(urlRequest)
        }
    }
    
    
    func hindPicture(){
        DispatchQueue.main.async {
            self.pictures.isHidden = true
            self.webView.isHidden = true
        }
    }
    @IBAction func p01(_ sender: Any) {
        targetPictures = picturesA
        picturesSubTitle = "永念亭"
        performSegue(withIdentifier: "goPic", sender: self)
    }
    
    @IBAction func p02(_ sender: Any) {
        targetPictures = picturesB
        picturesSubTitle = "福田妙國"
        performSegue(withIdentifier: "goPic", sender: self)
    }


    @IBAction func p03(_ sender: Any) {
        targetPictures = picturesC
        picturesSubTitle = "永念亭拜飯"
        performSegue(withIdentifier: "goPic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PictureViewController
        
        vc.theTitle = picturesSubTitle
        vc.pictures = targetPictures
    }
    
}
