//
//  Area1Traffic.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/10.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts


class Area1Traffic: UIView {
    
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
        let url = NSURL(string: "tel://02-2459-1122")
        telWeb.loadRequest(URLRequest(url: url! as URL))
    }
    
    
    @IBAction func goMap1(_ sender: Any) {
        openMapForPlace1()
    }
    
    func openMapForPlace1() {
        
        let lat1 : NSString = "25.1033446"
        let lng1 : NSString = "121.7438073"
        
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
        mapItem.name = "永念庭生命園區"
        mapItem.openInMaps(launchOptions: options)
        
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
