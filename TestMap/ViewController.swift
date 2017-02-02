//
//  ViewController.swift
//  TestMap
//
//  Created by Hieu Vo on 1/31/17.
//  Copyright © 2017 Hieu Vo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        let uispgr = UITapGestureRecognizer(target: self, action: #selector(self.shortPress(gestureRecognizer:)))
        uispgr.numberOfTapsRequired = 1
        map.addGestureRecognizer(uilpgr)
        map.addGestureRecognizer(uispgr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shortPress(gestureRecognizer : UIGestureRecognizer){
        self.locationManager.stopUpdatingLocation()
        print("stop")
    }
    
    func longPress(gestureRecognizer : UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: self.map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        let startAnntation = MKPointAnnotation()
        startAnntation.coordinate = coordinate
        map.addAnnotation(startAnntation)
        self.locationManager.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      //  print(locations)
        let userLocations : CLLocation = locations[0]
        let longitude = userLocations.coordinate.longitude
        let latidude = userLocations.coordinate.latitude
        let latDelta : CLLocationDegrees = 0.05
        let lonDelta : CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latidude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "yes"
        annotation.subtitle = "sub title"
        self.map.addAnnotation(annotation)
    }

}

