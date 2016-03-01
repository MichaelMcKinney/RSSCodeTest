//
//  listVM.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import ObjectMapper


//View Model for List View Controller

class listVM: NSObject{
	
	let JSON_INFO_URL = "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=8&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss"
	var stories: [story] = []
	
	override init() {
		super.init()
		self.getJson()
		print("Did init listVM")
	}
	
//	func getStoryAtIndex(index: Int) -> story{
//		
//		//xml["root"]["h:table"]["h:tr"]["h:td"][0].element!.text!
//		
//		//return xmlParser.getStoryAtIndex(index)
//	}
	
	private func getJson(){
		let JSONString = self.getURLContents()
		
		let SW = Mapper<storyWrapper>().map(JSONString)
		
		print("did get JSON... maybe")
		//self.stories = (SW?.responseData?.feed?.entries)!
	}
	
	private func getURLContents() -> String{
		var json: NSString = ""
		do {
			json = try NSString(contentsOfURL: NSURL(string: JSON_INFO_URL)!, encoding: NSUTF8StringEncoding)
		}
		catch{print(error)}
		
		return json as String
	}

	
	
	
}
