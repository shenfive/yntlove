//
//  FifthViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit



class FifthViewController: UIViewController {

    
    var netWorkStatusTimer = Timer()
    var testCount = 0
    let mainThread = Thread.main
    let webView = UIWebView()
    let theServer = "https://f5f.yntlove.com/"
    
   

    @IBOutlet weak var pictures: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        netWork()
        // Do any additional setup after loading the view.
        pictures.isHidden = true
        let rect = CGRect(x: self.view.frame.origin.x,
                          y: self.view.frame.origin.y + 73,
                          width: self.view.frame.width,
                          height: self.view.frame.height - 73)
        
        
        webView.frame = rect
        webView.isHidden = true
        self.view.addSubview(webView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(_ sender: Any) {
        testCount += 1
        print(testCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        netWorkStatusTimer = Timer.scheduledTimer(timeInterval: 4 , target: self, selector: #selector(self.netWork), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        netWorkStatusTimer.invalidate()
    }
    
    func netWork(){
        print(self.pictures.isHidden)
        let reachablility = Reachability(hostName: "www.apple.com")
        if reachablility?.currentReachabilityStatus().rawValue != 0 {
            print("網路通的")
            let urlString = self.theServer + "mobile/in"
            let url = URL(string: urlString)
            let urlRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 3.9)
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
        let urlRequest = URLRequest(url: URL(string:theServer + "MUser/login")!)
        webView.loadRequest(urlRequest)
    }
    
    
    func hindPicture(){
        DispatchQueue.main.async {
            self.pictures.isHidden = true
            self.webView.isHidden = true
        }
    }
    
}
