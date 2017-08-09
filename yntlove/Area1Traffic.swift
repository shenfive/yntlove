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

class Area1Traffic: UIView {
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

}
