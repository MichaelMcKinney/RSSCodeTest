//
//  story.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation

class story: NSObject{
	
	var title = ""
	var link = ""
	var guid = ""
	var category = ""
	var pubDate = ""
	var shortStory = ""
	var imageLink = ""
	
	override init(){
		
	}
	
	static func nullStory() -> story{
		let emptyStory = story()
		emptyStory.title = "Something Went Wrong..."
		emptyStory.shortStory = "Story could not be loaded"
		return emptyStory
	}
	
	
	
}