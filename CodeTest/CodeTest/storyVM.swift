//
//  storyVM.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation

class storyVM: NSObject{
	
	let URL: String
	let isOffline: Bool
	
	required init(url:String, isOff: Bool){
		self.URL = url
		isOffline = isOff
	}

	
}