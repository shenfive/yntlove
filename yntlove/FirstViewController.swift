//
//  FirstViewController.swift
//  yntlove
//
//  Created by 申潤五 on 2017/8/3.
//  Copyright © 2017年 申潤五. All rights reserved.
//

import UIKit
import Contacts
import CoreLocation
import MapKit

class FirstViewController: UIViewController {
    
    let telWeb = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tel(_ sender: UIButton) {
        let url = NSURL(string: "tel://0979088745")
        telWeb.loadRequest(URLRequest(url: url! as URL))
        print("test")
    }

    @IBAction func addAdressBook(_ sender: Any) {
        
        
        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
            if isRight{
                self.addContact()
            }
        }
    }
    
    func addContact(){
        //创建通讯录对象
        let store = CNContactStore()
        
        //创建CNMutableContact类型的实例
        let contactToAdd = CNMutableContact()
        
        //设置姓名
        contactToAdd.familyName = "李"
        contactToAdd.givenName = "蛋蛋"
        
        //设置昵称
        contactToAdd.nickname = "高高"
        
        //设置头像
//        let image = UIImage(named: "fei")!
//        contactToAdd.imageData = UIImagePNGRepresentation(image)
        
        //设置电话
        let mobileNumber = CNPhoneNumber(stringValue: "0979088745")
        let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile,
                                         value: mobileNumber)
        contactToAdd.phoneNumbers = [mobileValue]
        
        //设置email
        let email = CNLabeledValue(label: CNLabelHome, value: "a@b.c" as NSString)
        contactToAdd.emailAddresses = [email]
        
        //添加联系人请求
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
        
        do {
            //写入联系人
            try store.execute(saveRequest)
            print("保存成功!")
        } catch {
            print(error)
        }
    }
    @IBAction func goMap(_ sender: Any) {
        
        print("go Map")
        openMapForPlace()
    }
    
    
    func openMapForPlace() {
    
        let lat1 : NSString = "25.0874045"
        let lng1 : NSString = "121.4627575"
    
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
        mapItem.name = "這是一個測試"
        mapItem.openInMaps(launchOptions: options)
        
    }
}

