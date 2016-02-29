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
	
	func setTestText(text: String){
		
		self.testLabel.text = text
	}
	
	
}
