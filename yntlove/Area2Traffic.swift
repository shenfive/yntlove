//
//  Area2Traffic.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/10.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class Area2Traffic: UIView {
    let telWeb = UIWebView()
    var hostVC:UIViewController? = nil
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
    @IBAction func call1(_ sender: Any) {
        let url = NSURL(string: "tel://02-2498-0666")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }
    @IBAction func call2(_ sender: Any) {
        let url = NSURL(string: "tel://02-2498-6200")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }
    
    @IBAction func call3(_ sender: Any) {
        let url = NSURL(string: "tel://02-2504-7000")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }

    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    @IBAction func goMap(_ sender: Any) {
        openMapForPlace1()
    }
    
    func openMapForPlace1() {
        
        let lat1 : NSString = "25.193946"
        let lng1 : NSString = "121.6596583"
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "福田妙國生命紀念館"
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    @IBAction func addAddress3(_ sender: Any) {
        addContact3()
    }
    
    func addContact3(){
        // 查詢是否有加入過
        let defult = UserDefaults.standard
        if defult.bool(forKey: "added3") == true {
            print("added")
            let alert = UIAlertController(title: "說明", message: "您曾經有加入【福田妙國生命記念館】為連絡人了", preferredStyle: .alert)
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
        contactToAdd.givenName = "福田妙國生命記念館"
        
        
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
        
        
        contactToAdd.phoneNumbers = [workValue,workValue2,workValue3]
        
        
        //地址
        let address =  CNMutablePostalAddress()
        address.city = "新北市"
        address.street = "萬里區磺潭里員潭號 22-3號 "
        
        contactToAdd.postalAddresses = [CNLabeledValue<CNPostalAddress>(label: CNLabelWork, value: address)]
        
        //添加联系人请求
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
        
        do {
            //写入联系人
            try store.execute(saveRequest)
            print("保存成功!")
            defult.set(true, forKey: "added3")
            defult.synchronize()
            let alert = UIAlertController(title: "說明", message: "成功加入【福田妙國生命記念館】為連絡人", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "確認", style: .default, handler: nil)
            alert.addAction(okButton)
            hostVC?.present(alert, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}
