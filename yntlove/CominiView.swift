//
//  CominiView.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/9.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit
import Contacts

class CominiView: UIView {

    var hostVC:UIViewController? = nil
    let telWeb = UIWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

    @IBAction func call1(_ sender: Any) {
        callN1()
    }
    
    
    @IBAction func call2(_ sender: Any) {
        callN2()
    }
    @IBAction func openFBinSafari(_ sender: Any) {
        
        let application = UIApplication.shared
        let myUrl = URL(string: "https://www.facebook.com/%E6%B0%B8%E5%BF%B5%E5%BA%AD%E7%94%9F%E5%91%BD%E5%85%B8%E8%97%8F%E9%A4%A8-505671212949872/?fref=ts")
        if #available(iOS 10.0, *) {
            application.open(myUrl!, options: [:], completionHandler: nil)
        } else {
            application.openURL(myUrl!)
            // Fallback on earlier versions
        }
        
    }
    
    @IBAction func openOWinSafari(_ sender: Any) {
        let application = UIApplication.shared
        let myUrl = URL(string: "http://www.unameteam.com.tw/")
        if #available(iOS 10.0, *) {
            application.open(myUrl!, options: [:], completionHandler: nil)
        } else {
            application.openURL(myUrl!)
            // Fallback on earlier versions
        }
    }
    func callN1(){
        let url = NSURL(string: "tel://02-2504-7000")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }
    
    func callN2(){
        let url = NSURL(string: "tel://02-2459-1122")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }
    
    @IBAction func addAddress1(_ sender: Any) {
        addContact1()
    }
    
    
    func addContact1(){
        // 查詢是否有加入過
        let defult = UserDefaults.standard
        if defult.bool(forKey: "added1") == true {
            print("added")
            let alert = UIAlertController(title: "說明", message: "您曾經有加入【聖德福田妙國股份有限公司】為連絡人了", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default, handler: nil)
            alert.addAction(okButton)
            
            hostVC?.present(alert, animated: true, completion: nil)
            return
        }
        
        //创建通讯录对象
        let store = CNContactStore()
        
        //创建CNMutableContact类型的实例
        let contactToAdd = CNMutableContact()
        
        //设置姓名
        contactToAdd.familyName = ""
        contactToAdd.givenName = "聖德福田妙國股份有限公司"
        
        
        //设置电话
        let phoneNumber = CNPhoneNumber(stringValue: "02-2504-7000")
        let workValue = CNLabeledValue(label: CNLabelWork,
                                         value: phoneNumber)

        let phoneNumber2 = CNPhoneNumber(stringValue: "02-2498-6200")
        let workValue2 = CNLabeledValue(label: CNLabelWork,
                                       value: phoneNumber2)
        
        let phoneNumber3 = CNPhoneNumber(stringValue: "02-2498-0666")
        let workValue3 = CNLabeledValue(label: "接駁車專線",
                                        value: phoneNumber3)
        
        
        contactToAdd.phoneNumbers = [workValue, workValue2, workValue3]
        
        
        //地址
        let address =  CNMutablePostalAddress()
        address.city = "台北市"
        address.street = "中山區民權東路二段160號 1 樓"
        
        contactToAdd.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelWork, value: address)]
        
        //添加联系人请求
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
        
        do {
            //写入联系人
            try store.execute(saveRequest)
            print("保存成功!")
            defult.set(true, forKey: "added1")
            defult.synchronize()
            let alert = UIAlertController(title: "說明", message: "成功加入【聖德福田妙國股份有限公司】為連絡人", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default, handler: nil)
            alert.addAction(okButton)
            hostVC?.present(alert, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    @IBAction func addAddress2(_ sender: Any) {
        addContact2()
    }
    
    func addContact2(){
        // 查詢是否有加入過
        let defult = UserDefaults.standard
        if defult.bool(forKey: "added2") == true {
            print("added")
            let alert = UIAlertController(title: "說明", message: "您曾經有加入【永念庭園區】為連絡人了", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default, handler: nil)
            alert.addAction(okButton)
            
            hostVC?.present(alert, animated: true, completion: nil)
            return
        }
        
        //创建通讯录对象
        let store = CNContactStore()
        
        //创建CNMutableContact类型的实例
        let contactToAdd = CNMutableContact()
        
        //设置姓名
        contactToAdd.familyName = ""
        contactToAdd.givenName = "永念庭園區"
        
        
        //设置电话
        let phoneNumber = CNPhoneNumber(stringValue: "02-2459-1122")
        let workValue = CNLabeledValue(label: CNLabelWork,
                                       value: phoneNumber)
        
        
        
        contactToAdd.phoneNumbers = [workValue]
        
        
        //地址
        let address =  CNMutablePostalAddress()
        address.city = "基隆市"
        address.street = "暖暖區興隆街 14-15號"
        
        contactToAdd.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelWork, value: address)]
        
        //添加联系人请求
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
        
        do {
            //写入联系人
            try store.execute(saveRequest)
            print("保存成功!")
            defult.set(true, forKey: "added2")
            defult.synchronize()
            let alert = UIAlertController(title: "說明", message: "成功加入【永念庭園區】為連絡人", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default, handler: nil)
            alert.addAction(okButton)
            hostVC?.present(alert, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
}
