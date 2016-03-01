//
//  story.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import Curry
import Argo

struct story{
	
	var title: String
	var link: String
	var publishedDate: String
	var contentSnippet: String
	var content: String
	var imageLink: String
	
}

extension story: Decodable {
	static func decode(j: JSON) -> Decoded<story> {
		return curry(story.init)
			<^> j <| "title"
			<*> j <| "link"
			<*> j <| "publishedDate"
			<*> j <| "contentSnippet"
			<*> j <| "content"
	}
}
