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
	
	//MARK: Initialization
	override init() {
		super.init()
		self.getJson()
		print("Did init listVM")
	}
	
	private func getJson(){
		let JSONString = self.getURLContents()
		
		let SW = Mapper<storyWrapper>().map(JSONString)
		
		self.stories = (SW?.responseData?.feed?.entries)!
		print("did get JSON")
	}
	
	private func getURLContents() -> String{
		var json: NSString = ""
		do {
			json = try NSString(contentsOfURL: NSURL(string: JSON_INFO_URL)!, encoding: NSUTF8StringEncoding)
		}
		catch{print(error)}
		
		return json as String
	}
	
	//MARK: Tableview
	func getNumberOfStories() -> Int{
		return stories.count
	}
	
	func getStoryAtIndex(index: Int) -> story{
		return stories[index]
	}
	
	func getImageAtIndex(index: Int) -> UIImage{
		
		let tempURL = NSURL(string: stories[index].imageLink!)!
		var imageData = NSData()
		do{
			imageData = try NSData(contentsOfURL: tempURL, options:NSDataReadingOptions.DataReadingUncached)
		}
		catch{
			print(error)
			UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), false, 0.0)
			let blank = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			return blank
		}
		
		let tempImage =  UIImage(data: imageData)
		return tempImage!
	}

	
	
	
}
