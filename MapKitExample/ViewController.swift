//
//  ViewController.swift
//  MapKitExample
//
//  Created by Javier Cruz Santiago on 2/6/19.
//  Copyright © 2019 Javier Cruz Santiago. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var regionRadius: CLLocationDistance! = 1000
    var mapView: MKMapView!
    
    func createView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        locManager.delegate = self
        
        mapView = MKMapView()
        mapView.backgroundColor = .white
        mapView.layer.cornerRadius = 20
        mapView.delegate = self
    }
    
    func addViews() {
        view.addSubview(mapView)
    }
    
    func setupLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.height)! + 10).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        addViews()
        setupLayout()
        locManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locManager.location
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            annotation.title = "Javier Cruz Santiago"
            annotation.subtitle = "Estás aquí"
            mapView.addAnnotation(annotation)
        }
    }
}

extension ViewController {
    func printLocation(location: CLLocation) {
        print("Latitude: \(location.coordinate.latitude)")
        print("Longitude: \(location.coordinate.longitude)")
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .denied {
            printLocation(location: locManager.location!)
            centerMapOnLocation(location: locManager.location!)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
}

