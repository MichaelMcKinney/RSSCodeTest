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
	var images: [UIImage] = []
	
	var isConnected = true
	
	//MARK: Initialization
	override init() {
		super.init()
		self.getJson()
		print("Did init listVM")
	}
	
	private func getJson(){
		let JSONString = self.getURLContents()
		
		if (JSONString.characters.count == 0){ //NO STORIES LOADED
			return
		}
		
		let SW = Mapper<storyWrapper>().map(JSONString)
		
		self.stories = (SW?.responseData?.feed?.entries)!
		print("did get JSON")
	}
	
	private func getURLContents() -> String{
		var json: NSString = ""
		let prefs = NSUserDefaults.standardUserDefaults()
		
		if (Reachability.isConnectedToNetwork()){
			print("Connected to Network")
			isConnected = true
			do {
				json = try NSString(contentsOfURL: NSURL(string: JSON_INFO_URL)!, encoding: NSUTF8StringEncoding)
			}
			catch{print(error)}
			
			prefs.setValue(json, forKey: "lastJSON")
		}
		else{
			print("NOT Connected to Network")
			isConnected = false
			if let tempString = prefs.stringForKey("lastJSON"){
				json = tempString
			}
		}
		
		return json as String
	}
	
	//MARK: Refresh Data
	func refreshData(completion:Void){
		getJson()
		completion
	}
	
	//MARK: Tableview
	func getNumberOfStories() -> Int{
		return stories.count
	}
	
	func getStoryAtIndex(index: Int) -> story{
		return stories[index]
	}
	
	func getImageAtIndex(index: Int) -> UIImage{
		
	
		
		if (images.count-1>=index){
			return images[index]
		}
		
		let tempURL = NSURL(string: "http://" + stories[index].imageLink!)!
		var imageData = NSData()
		
		print("MADE CALL FOR IMAGE")
		
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
		images.insert(tempImage!, atIndex: index)
		
		print("FINISHED CALL FOR IMAGE")
		
		return tempImage!
	}
	
	func getURLAtIndex(index: Int) ->NSURL{
		return NSURL(string:self.getStoryAtIndex(index).link!)!
		
	}
	
	func getLinkAtIndex(index: Int) ->String{
		return self.getStoryAtIndex(index).link!
	}

	
	

	
	
	
}
