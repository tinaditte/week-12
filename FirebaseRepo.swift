//
//  FirebaseRepo.swift
//  MapDemo
//
//  Created by Tina Thomsen on 20/03/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseRepo{
	
	//Static access w/o having to instantiate the class
	
	private static let db = Firestore.firestore()
	private static let path = "locations"
	
	static func startListener(vc: ViewController){
		//when there is a result call
		//vc.updateMarkers()
		db.collection(path).addSnapshotListener{ (snap, error) in
			if error != nil{ //check if there is an error
				return
			}
			if let snap = snap {
				//if snap does have a value -> reassigned to another val and call snap
				//a way of unwrapping the snap optional
				vc.updateMarkers(snap: snap)
			}
		}
	}
	
	static func addMarker(title:String, lat: Double, long: Double){
		let ref = db.collection(path).document()
		var map = [String:Any]()
		map["text"] = title
		map["coordinates"] = GeoPoint(latitude: lat, longitude: long)
		ref.setData(map)
		
	}
	
//	static func addUserMarkers(anno: MKPointAnnotation, coordinate: GeoPoint, text: String){
//		var ref: DocumentReference? = nil
//		
//		ref = db.collection("locatons").addDocument(data: [
//			"coordinates" : coordinate,
//			"text" : text
//		]){ err in
//			if let err = err{
//				print("Error while adding new doc: \(err)")
//			}else{
//				print("New location added with ID: \(ref!.documentID)")
//			}
//		}
//		let anno = MKPointAnnotation()
//		let annoLong = anno.coordinate.longitude
//		let annoLat = anno.coordinate.latitude
//		let coords =  GeoPoint(latitude: annoLat, longitude: annoLong)
//		let markerid = ref?.documentID
//		let markertext = anno.title
//		
//		
//		let newUserMarker = UserMarker(id: markerid, coordinates: coords, text: markertext)
//		
//		
//		
//	}
	
}
