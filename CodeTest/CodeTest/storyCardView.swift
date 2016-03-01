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
	}
	
	func setPreviewPicture(picture: UIImage){
		
		gradientImage.hidden = true
		//TODO: set Gradient image to something real
		storyImage.image = picture
		
	}
	
	
	func setMainText(text: String){
		
		self.titleText.text = text
	}
	
}
