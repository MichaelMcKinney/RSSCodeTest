//
//  jsonReader.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import ObjectMapper

class storyWrapper: NSObject, Mappable{
	
	var responseData: Response?
	
	required init?(_ map: Map) {
		
	}

	// Mappable
	func mapping(map: Map) {
		responseData    <- map["responseData"]
	}
}


class Response: NSObject, Mappable{
	
	var feed: Feed?
	
	required init?(_ map: Map) {
		
	}
	
	// Mappable
	func mapping(map: Map) {
		feed    <- map["feed"]
	}
}


class Feed: NSObject, Mappable{
	
	var entries: [story]?
	
	required init?(_ map: Map) {
		
	}
	
	// Mappable
	func mapping(map: Map) {
		entries    <- map["entries"]
	}
}










