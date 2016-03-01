//
//  storyCardView.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import UIKit

class storyCardView: UIView{
	
	@IBOutlet var baseView: UIView!
	@IBOutlet var storyImage: UIImageView!
	@IBOutlet var gradientImage: UIImageView!
	
	@IBOutlet var subText: UILabel!
	@IBOutlet var titleText: UILabel!
	
	class func instanceFromNib() -> UIView {
		return UINib(nibName: "cardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
	}
	
	func setSubTitle(text: String){
		
		self.subText.text = text
		self.subText.numberOfLines = 0
	}
	
	func setPreviewPicture(picture: UIImage){
		
		storyImage.image = picture
		
	}
	
	
	func setMainText(text: String){
		
		self.titleText.text = text
		self.titleText.numberOfLines = 0
		
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		//if (UIEvent.)
	}
	
}
