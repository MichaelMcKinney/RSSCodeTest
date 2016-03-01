//
//  story.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import ObjectMapper


class story: NSObject, Mappable{
	
	var title: String?
	var link: String?
	var publishedDate: String?
	var contentSnippet: String?
	var content: String?
	var imageLink: String?

	required init?(_ map: Map) {
		
	}
	
	// Mappable
	func mapping(map: Map) {
		title    <- map["title"]
		link    <- map["link"]
		publishedDate    <- map["publishedDate"]
		contentSnippet    <- map["contentSnippet"]
		content    <- map["content"]

	}
}


