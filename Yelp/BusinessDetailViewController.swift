//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Marcel Weekes on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit

class BusinessDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var businessImageView: UIImageView!
    
    // set by the presenting controller
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessNameLabel.text = business.name
        reviewCountLabel.text = "\(business.reviewCount!) Reviews"
        configureMap()
        if let imageURL = business.imageURL {
            businessImageView.setImageWithURL(imageURL)
        }

    }

    func configureMap() {
        let centerCoordinate = CLLocationCoordinate2DMake((business.latitude?.doubleValue)!, (business.longitude?.doubleValue)!)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        mapView.setRegion(MKCoordinateRegionMake(centerCoordinate, span), animated: false)
        
        let pin = MKPointAnnotation()
        pin.coordinate = centerCoordinate
        mapView.addAnnotation(pin)
    }


}
