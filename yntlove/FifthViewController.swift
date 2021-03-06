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
    @IBOutlet weak var topLogo: UIImageView!
    
    var netWorkStatusTimer = Timer()
    var testCount = 30
    let mainThread = Thread.main
    let webView = UIWebView()
    let button = UIButton()
    let theServer = "https://5f.yntlove.com/"
    
    var picturesA = [UIImage]()
    var picturesB = [UIImage]()
    var picturesC = [UIImage]()
    var targetPictures = [UIImage]()
    var picturesSubTitle = ""


    @IBOutlet weak var pictures: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.selectedImage = UIImage(named: "icon_photo_h")
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
                          y: self.view.frame.origin.y + 40,
                          width: self.view.frame.width,
                          height: self.view.frame.height - 53)
        webView.frame = rect
        webView.isHidden = true
        button.frame = CGRect(x: 0, y: 20, width: 90, height: 20)
        button.setImage(UIImage(named:"icon_back_ph"), for: .normal)
        button.setTitle("", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(self.hindWeb), for: .touchUpInside)
      
        
        self.view.addSubview(webView)
        self.view.addSubview(button)
        
    }
    
    func hindWeb(){
        self.button.isHidden = true
        self.webView.isHidden = true
        self.topLogo.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        netWorkStatusTimer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(self.netWork), userInfo: nil, repeats: true)
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
            let urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
            let session = URLSession.shared
            session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error == nil{
                    if ((response as! HTTPURLResponse).statusCode) == 200 {

                        if let contentString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?{
                            if contentString == "in"{
                                self.testCount = 0
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
        self.topLogo.isHidden = true
        if webView.isLoading == false{
            let urlRequest = URLRequest(url: URL(string:theServer + "MUser/login")!)
            webView.loadRequest(urlRequest)
        }
    }
    
    
    func hindPicture(){
        print(testCount)
        if testCount > 30 {
            realhindPicture()
        }else{
            testCount += 1
        }
    }
    func realhindPicture(){
        print ("%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        DispatchQueue.main.async {
            self.pictures.isHidden = true
            self.webView.isHidden = true
            self.button.isHidden = true
            self.topLogo.isHidden = false
        }
    }
    
    
    @IBAction func p01(_ sender: Any) {
        targetPictures = picturesA
        picturesSubTitle = "永念庭"
        performSegue(withIdentifier: "goPic", sender: self)
    }
    
    @IBAction func p02(_ sender: Any) {
        targetPictures = picturesB
        picturesSubTitle = "福田妙國"
        performSegue(withIdentifier: "goPic", sender: self)
    }


    @IBAction func p03(_ sender: Any) {
        targetPictures = picturesC
        picturesSubTitle = "永念庭拜飯"
        performSegue(withIdentifier: "goPic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PictureViewController
        
        vc.theTitle = picturesSubTitle
        vc.pictures = targetPictures
    }
    
}
