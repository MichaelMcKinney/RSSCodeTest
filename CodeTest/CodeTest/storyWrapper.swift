//
//  jsonReader.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import Curry
import Argo

struct storyWrapper{
	
	let responseData: Response
}

extension storyWrapper: Decodable {
	
	static func decode(j: JSON) -> Decoded<storyWrapper> {
		return curry(storyWrapper.init)
			<^> j <| "responseData" // parse feed object out
	}
	
}

struct Response{
	
	let feed: Feed
}

extension Response: Decodable {
	
	static func decode(j: JSON) -> Decoded<Response> {
		return curry(Response.init)
			<^> j <| "feed" // Custom types that also conform to Decodable just work
	}
	
}

struct Feed{
	
	let entries: [story]
}

extension Feed: Decodable {

	static func decode(j: JSON) -> Decoded<Feed> {
		return curry(Feed.init)
			<^> j <|| "entries" // parse arrays of objects
	}
}










