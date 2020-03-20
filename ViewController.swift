//
//  ViewController.swift
//  MapDemo
//
//  Created by Tina Thomsen on 20/03/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController  {

	@IBOutlet weak var map: MKMapView!
	@IBOutlet weak var textfield: UITextField!
	
	let locationManager = CLLocationManager()
	var userCoordinates = CLLocationCoordinate2D()
	var userMarker = [MKPointAnnotation]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization() //ask user to approve location sharing with the app
		locationManager.desiredAccuracy = kCLLocationAccuracyKilometer //how precise the location should be.
		
		createDemoMarker()
		
		//let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector(("setLocation:")))
		//gestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
		//map.addGestureRecognizer(gestureRecognizer)
		
		FirebaseRepo.startListener(vc: self)
		
	}
	
	@IBAction func setLocation(_ sender: UILongPressGestureRecognizer) {
		//have a pop up to get the title from
		if sender.state == .ended{ //limits amount of calls to just one
			//dont want to put a marker on the map ourselves, bc that will come from FB!
			let cgPoint = sender.location(in: map)
			let coordinate2D = map.convert(cgPoint, toCoordinateFrom: map)
			print("Long pressed:  \(coordinate2D)")
			
			//Get user data on title for new marker by popup or textfield, then create in firebase with text and geopoint
			let text = textfield.text
			
			FirebaseRepo.addMarker(title: text!, lat: coordinate2D.latitude, long: coordinate2D.longitude)
		}
		
	}
	
	func updateMarkers(snap: QuerySnapshot){ //getting raw data from firebaserepo
		let marker = MapDataAdapter.getMKAnnotationFromData(snap: snap)
		map.removeAnnotations(map.annotations)
		map.addAnnotations(marker)
		map.showsUserLocation = true

		//loop to iterate through the markers list
		//map.removeAnnotations(map.annotations) //clears map first
		//map.addAnnotations(markers)
	}
	
	fileprivate func createDemoMarker(){
		let marker = MKPointAnnotation() //Create an empty marker
		marker.title = "Go here" //msg on marker
		let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5) //DK location in world
		marker.coordinate = location //Add location to marker
		map.addAnnotation(marker) //annotation is a marker(red) where user can click for more info
	}
	@IBAction func startUpdate(_ sender: Any) {
		locationManager.startUpdatingLocation()
		
	}
	@IBAction func stopUpdate(_ sender: Any) {
		locationManager.stopUpdatingLocation()
		
	}
	
}

extension ViewController: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	
		if let coord = locations.last?.coordinate{
			let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
			map.setRegion(region, animated: true) //move map
		}
	}
}

//		let bestPizzaInKoege = MKPointAnnotation()
//		bestPizzaInKoege.title = "Pizza Love"
//		let pizzalocate = CLLocationCoordinate2D(latitude: 55.470230, longitude: 12.181349)
//		bestPizzaInKoege.coordinate = pizzalocate
//		map.addAnnotation(bestPizzaInKoege)
//
//		let tapperiet = MKPointAnnotation()
//		tapperiet.title = "Tapperiet"
//		let tapperietLocate = CLLocationCoordinate2D(latitude: 55.451307, longitude: 12.190736)
//		tapperiet.coordinate = tapperietLocate
//		map.addAnnotation(tapperiet)


//BELONGS IN SET LOCATION v
//		let location = gestureRecognizer.location(in: map)
//		let coordinates = map.convert(location, toCoordinateFrom: map)
//		let annotation = MKPointAnnotation()
//		annotation.coordinate = coordinates
//		map.addAnnotation(annotation)
//
//		userCoordinates = coordinates
//		let usercoordLong
//		let usercoordLat
////		print (coordinates)
//
//		FirebaseRepo.addUserMarkers(anno: annotation, )
		
