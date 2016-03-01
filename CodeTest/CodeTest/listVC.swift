//
//  ViewController.swift
//  CodeTest
//
//  Created by Michael McKinney on 2/29/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//
import Foundation
import UIKit

class listVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
	
	var viewModel = listVM()

	@IBOutlet var tableView: UITableView!
	
	//MARK: Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.assignViewModel(listVM())
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func assignViewModel(tempViewModel: listVM){
		
		self.viewModel = tempViewModel
	}
	
	
	//MARK: TableView Functions
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		self.performSegueWithIdentifier("showStory", sender: self)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("storyCell", forIndexPath: indexPath) as! storyCell

		//cell.setTestText("index is " + String(indexPath.row))
		cell.setTestText(viewModel.getStoryAtIndex(indexPath.row).title!)
		cell.setPreviewPicture(viewModel.getImageAtIndex(indexPath.row))
		cell.setSubTitle(viewModel.getStoryAtIndex(indexPath.row).contentSnippet!)
		
		return cell
		
			//TODO: PREPARE CELL WITH STORY INFO
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//TODO: GET NUMBER OF STORIES FROM VM

		return viewModel.getNumberOfStories()
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "showStory"){
			
			//TODO: PREPARE STORY TO BE PASSED OVER HERE
		}
	}

}

