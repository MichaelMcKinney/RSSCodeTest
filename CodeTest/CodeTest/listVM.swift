//
//  listVM.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import Argo
import Curry


//View Model for List View Controller

class listVM: NSObject{
	
	let JSON_INFO_URL = "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=8&q=http%3A%2F%2Fnews.google.com%2Fnews%3Foutput%3Drss"
	
	override init() {
		print("Did call listVM setup")
		
		print("Did init listVM")
	}
	
	func createStoryAtIndex(index: Int) -> story{
		
		//xml["root"]["h:table"]["h:tr"]["h:td"][0].element!.text!
		
		//return xmlParser.getStoryAtIndex(index)
	}
	
	private func getJsonString(){
		let data: NSData = self.getURLContents()
		let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
		
		if let j: AnyObject = json {
			let SW: storyWrapper? = decode(j)                  // ignore failure info or
			let decodedUser: Decoded<storyWrapper> = decode(j)   // preserve failure info
		}
		
		
	}
	
	private func getURLContents() -> NSData{
		var data: NSData
		do {
			data = NSData(contentsOfURL: NSURL(string: JSON_INFO_URL)!)!
		}
		
		return data
	}

	
	
	
}
