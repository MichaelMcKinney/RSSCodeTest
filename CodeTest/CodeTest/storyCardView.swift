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
	
	func setSubTitle(text: String){
		
		self.subText.text = text
	}
	
	func setPreviewPicture(picture: UIImage){
		
		storyImage.image = picture
		
	}
	
	
	func setMainText(text: String){
		
		self.titleText.text = text
	}
	
}
