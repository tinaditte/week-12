//
//  UserMarker.swift
//  MapDemo
//
//  Created by Tina Thomsen on 20/03/2020.
//  Copyright © 2020 Tina Thomsen. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class UserMarker{
	var id : String
	var coordinates : GeoPoint
	var text : String
	
	init(id:String, coordinates : GeoPoint, text : String) {
		self.id = id
		self.coordinates = coordinates
		self.text = text
	}
	
}
