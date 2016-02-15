//
//  BusinessesMapViewController.swift
//  Yelp
//
//  Created by Marcel Weekes on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class BusinessesMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var businesses: [Business]!
    var pins: [MKPointAnnotation]!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        configureMap()
        pins = [MKPointAnnotation]()
    }
    
    func configureMap() {
        let centerCoordinate = CLLocationCoordinate2DMake(37.785771, -122.406165)
        let span = MKCoordinateSpanMake(0.08, 0.08)
        mapView.setRegion(MKCoordinateRegionMake(centerCoordinate, span), animated: false)
    }
    
    
    // MARK: - Map methods

    func addMarkersToMap() {
        if let locations = businesses {
            for loc in locations {
                let pin = MKPointAnnotation()
                let latLng = CLLocationCoordinate2DMake((loc.latitude?.doubleValue)!, (loc.longitude?.doubleValue)!)
                pin.coordinate = latLng
                pins.append(pin)
            }
            mapView.addAnnotations(pins)
        }
    }
    
    func updateMapRegionToIncludePins() {
        if !pins.isEmpty {
            mapView.showAnnotations(pins, animated: true)
        }
    }

}


// MARK: - MKMapViewDelegate

extension BusinessesMapViewController: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        addMarkersToMap()
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        updateMapRegionToIncludePins()
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let latitude = view.annotation?.coordinate.latitude
        let longitude = view.annotation?.coordinate.longitude
        let appleMapsURL = "http://maps.apple.com/?q=\(latitude!),\(longitude!)"
        UIApplication.sharedApplication().openURL(NSURL(string: appleMapsURL)!)
    }

}