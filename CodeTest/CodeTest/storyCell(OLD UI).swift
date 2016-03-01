//
//  storyCell.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import UIKit

class storyCell: UITableViewCell{
	
	
	@IBOutlet var testLabel: UILabel!
	@IBOutlet var subText: UILabel!
	@IBOutlet var previewImage: UIImageView!
	
	
	func setSubTitle(text: String){
		
		self.subText.text = text
	}
	
	func setPreviewPicture(picture: UIImage){
		
		previewImage.image = picture
	
	}
	
	
	func setTestText(text: String){
		
		self.testLabel.text = text
	}
	
	
}
