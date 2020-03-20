//
//  MapDataAdapter.swift
//  MapDemo
//
//  Created by Tina Thomsen on 20/03/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class MapDataAdapter{
	
	static func getMKAnnotationFromData(snap: QuerySnapshot) -> [MKPointAnnotation]  {
		var markers = [MKPointAnnotation]() //Creates empty list of MKPointAnnotations
		for doc in snap.documents {
			print("received ID data: ")
			print(doc.documentID)
			let map = doc.data()
			let text = map["text"] as! String
			let geoPoint = map["coordinates"] as! GeoPoint
			let mkAnno = MKPointAnnotation()
			mkAnno.title = text
			let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
			mkAnno.coordinate = coordinate
			markers.append(mkAnno)
		
		}
		return markers
	}
}
