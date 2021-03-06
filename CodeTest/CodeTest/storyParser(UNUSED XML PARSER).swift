////
////  storyParser.swift
////  CodeTest
////
////  Created by Michael McKinney on 2/29/16.
////  Copyright © 2016 CentricConsulting. All rights reserved.
////
//
//
//import Foundation
//import SWXMLHash
//
//class storyParser:  NSObject{
//	
//	let URL = NSURL(string:"https://news.google.com/news?hl=en&pz=1&ned=us&output=rss")
//	var XML: XMLIndexer?
//	var stringXML: String?
//
//	func setupXML(){
//		self.XML = self.getPureXML().0
//		self.stringXML =  self.getPureXML().1
//		print("Did setup XML in Parser")
//		//print("\r\n"+self.stringXML!+"\r\n")
//	}
//	
//	private func getXMLStrigContents() -> String{
//		var html = NSString()
//		do {
//			html = try NSString(contentsOfURL: self.URL!, encoding: NSUTF8StringEncoding)
//		}
//		catch{print(error)}
//		return html as String
//	}
//	
//	private func getPureXML() -> (XMLIndexer,String){
//		let html = self.getXMLStrigContents()
//		let xml = SWXMLHash.parse(html)
//		return (xml,html)
//	}
//	
//	//MARK: Informational
//
//	
//	func getNumberStories() -> Int{
//		
//		//return number of "items" in the xml
//		return self.XML!["root"]["channel"].all.count-9
//	}
//	
//	func getStoryAtIndex(index: Int) ->story{
//		
//		let elem = self.XML!["rss"]["channel"].children[index+9]
//		if (elem.element!.name != "item"){
//			return story.nullStory()
//		}
//		else{
//			let buildStory = story()
//			
//			//Assign Title
//			buildStory.title = elem.children[0].element!.text!
//			
//			//Assign shortStory
//			//First occurrance of this: "font&gt;&lt;br&gt;&lt;font size=&quot;-1&quot;&gt;" until this "...&lt;" STARTS AT HASH INDEX 226-227
//			let descriptionString = elem.children[5].element!.text!
//			
//			//let someOtherString = elem["description"].element!.
//			//let descripRange1: Range<String.Index> = descriptionString.rangeOfString("font&gt;&lt;br&gt;&lt;font size=&quot;-1&quot;&gt;")!
//			//let firstDescripString = descriptionString.substringFromIndex(descripRange1.endIndex)
//			
//			//let descripRange2: Range<String.Index> = firstDescripString.rangeOfString("...&lt;")!
//			//let finalDescripString = firstDescripString.substringToIndex(descripRange2.startIndex)
//
//			//buildStory.shortStory = finalDescripString
//			
//			//Assign Story Link
//
//			buildStory.link = elem.children[1].element!.text!
//			
//			//Assign Image Link
//			let range: Range<String.Index> = descriptionString.rangeOfString("<img src=\"")!
//			let range2: Range<String.Index> = descriptionString.rangeOfString("\" alt=")!
//			//let imageStartIndex: Int = imageString.startIndex.distanceTo(range.endIndex)
//			//let imageEndIndex: Int = imageString.startIndex.distanceTo(range2.startIndex)
//			let trueImageString = descriptionString[range.endIndex.advancedBy(2)...range2.startIndex.predecessor()] //imageString.substringWithRange(NSRange(location: imageStartIndex, length: length))
//			buildStory.imageLink = trueImageString
//			
//			
//			
//			
//			return buildStory
//		}
//	}
//	
//	
//
//}
