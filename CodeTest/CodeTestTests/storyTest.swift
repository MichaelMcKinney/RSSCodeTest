//
//  storyTest.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/2/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import CodeTest

class storyTest: XCTestCase {
	
	var fakeJSON: String = ""
	
    override func setUp() {
        super.setUp()
		//create JSON from File
		
		fakeJSON = self.readJSONfromFile("testJSON.txt")
		//NSUTF8StringEncoding
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	//Cannot pass tests because file cannot be read in
	func readJSONfromFile(fileName:String) -> String{
		var temp = ""
	
		let path = NSBundle(forClass: self.dynamicType).pathForResource("testJSON", ofType: "txt")
		
		do{
			try temp = temp + String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
		}
		catch{
			print(error)
		}
		
		XCTAssert(temp.characters.count != 0)
		
		return temp
	}
	
	
	//Tests that Model wrapper properly creates intermediate properties to reach stories from JSON payload
    func testCreateStoryWrapper()
	{
		let testStoryWrapper = Mapper<storyWrapper>().map(fakeJSON)
		
		XCTAssertNotNil(testStoryWrapper?.responseData)
		XCTAssertNotNil(testStoryWrapper?.responseData?.feed)
		XCTAssertNotNil(testStoryWrapper?.responseData?.feed?.entries)
		
    }
	
	//Tests that stories are properly created within the Model wrapper
	func testCreateStories()
	{
		let testStoryWrapper = Mapper<storyWrapper>().map(fakeJSON)
		
		XCTAssertNotNil(testStoryWrapper?.responseData?.feed?.entries)
		let storyArray = testStoryWrapper?.responseData?.feed?.entries
		
		let firstStory = storyArray![0] 
		
		XCTAssertNotNil(firstStory.title)
		XCTAssert(firstStory.title?.characters.count != 0)
		
		XCTAssertNotNil(firstStory.link)
		XCTAssert(firstStory.link?.characters.count != 0)
		
		XCTAssertNotNil(firstStory.publishedDate)
		XCTAssert(firstStory.publishedDate?.characters.count != 0)
		
		XCTAssertNotNil(firstStory.contentSnippet)
		XCTAssert(firstStory.contentSnippet?.characters.count != 0)
		
		XCTAssertNotNil(firstStory.content)
		XCTAssert(firstStory.content?.characters.count != 0)
		
		XCTAssertNotNil(firstStory.imageLink)
		XCTAssert(firstStory.imageLink?.characters.count != 0)
	}
	
	//Test to make sure method of image parsing is correct.
	//Had to change parsing target string due to different encoding of "<" character.
	//uses first and last two characters of link to test it.
	func testParseImageLinkFromContentText(){
		
		//setup the text content
		let range: Range<String.Index> = fakeJSON.rangeOfString("\"content\"")!
		let range2: Range<String.Index> = fakeJSON.rangeOfString("\"categories\"")!
		
		let finalFake = fakeJSON[range.endIndex...range2.startIndex]
		
		
		//run through parser to make sure image link is retrieved
		let rangeStory: Range<String.Index> = finalFake.rangeOfString("img src\\u003d\\\"")!
		let rangeStory2: Range<String.Index> = finalFake.rangeOfString("\\\" alt\\u003d")!
		
		let trueImageString = finalFake[rangeStory.endIndex.advancedBy(2)...rangeStory2.startIndex.predecessor()]
		
		XCTAssert(trueImageString.characters.first == "t")
		XCTAssert(trueImageString.characters.last == "j")
		let secondToLast = trueImageString[trueImageString.endIndex.predecessor().predecessor()]
		XCTAssert(secondToLast == "P")

	}
	
	//Tests that Images are properly obtained from web for story link property
	func testGetImageFromWebForCell(){
		
		let testStoryWrapper = Mapper<storyWrapper>().map(fakeJSON)
		
		XCTAssertNotNil(testStoryWrapper?.responseData?.feed?.entries)
		let storyArray = testStoryWrapper?.responseData?.feed?.entries
		
		let firstStory = storyArray![0] 
		
		let tempURL = NSURL(string: "http://" + firstStory.imageLink!)!
		var imageData = NSData()
		
		do{
			imageData = try NSData(contentsOfURL: tempURL, options:NSDataReadingOptions.DataReadingUncached)
		}
		catch{
			print(error)
		}
		
		let tempImage =  UIImage(data: imageData)
		
		XCTAssertNotNil(tempImage)
	}
	
	
	
	
}
