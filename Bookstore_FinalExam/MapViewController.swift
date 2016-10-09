//
//  MapViewController.swift
//  Bookstore_FinalExam
//
//  Created by Chiu Chih-Che on 2016/10/7.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var address: String?
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var locationCoordinate2D: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //詢問權限
        self.locationManager.requestWhenInUseAuthorization()
        
        //地址轉換成座標，並標註在地圖上
        self.geoCoder.geocodeAddressString("\(address)", completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = "愛閱讀出版社"
                annotation.subtitle = "愛閱讀"
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    //self.mapView.addAnnotation(annotation)
                    //self.mapView.centerCoordinate = locationCoordinate2D!
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    self.mapView.setRegion(region, animated: true)
                }
            }
        })
        
        
        
    }

    @IBAction func dismissMap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
