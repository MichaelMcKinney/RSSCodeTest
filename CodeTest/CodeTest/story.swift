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
		
		self.setImage()
	}
	
	func setImage(){
		let range: Range<String.Index> = self.content!.rangeOfString("<img src=\"")!
		let range2: Range<String.Index> = self.content!.rangeOfString("\" alt=")!
		
		let trueImageString = self.content![range.endIndex.advancedBy(2)...range2.startIndex.predecessor()]
		self.imageLink = trueImageString
	}
}


