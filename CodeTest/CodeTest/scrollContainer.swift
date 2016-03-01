//
//  scrollContainer.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import UIKit

class scrollContainer: UIView {
	
	@IBOutlet var scrollView: UIScrollView!
 
	override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
		let view = super.hitTest(point, withEvent: event)
		if let theView = view {
			if theView == self {
				return scrollView
			}
		}
		
		return view
	}
}