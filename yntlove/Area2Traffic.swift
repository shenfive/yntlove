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

class Area2Traffic: UIView {
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
}
