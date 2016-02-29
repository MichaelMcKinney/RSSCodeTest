//
//  listVM.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation


//View Model for List View Controller

class listVM: NSObject{
	
	let xmlParser = storyParser()
	
	override init() {
		print("Did call listVM setup")
		xmlParser.setupXML()
		print("Did init listVM")
	}
	
	func createStoryAtIndex(index: Int) -> story{
		
		//xml["root"]["h:table"]["h:tr"]["h:td"][0].element!.text!
		
		return xmlParser.getStoryAtIndex(index)
	}
	
	
	
}
