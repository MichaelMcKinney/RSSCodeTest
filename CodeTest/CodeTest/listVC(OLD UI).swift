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
	
	var viewModel: listVM?
	var selectedIndex: Int = 0

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
	
	//MARK: Offline Indicator
	
	func showOfflineIndicator(){
		let alert = UIAlertController(title: "Offline", message: "Cannot load new stories. Check Network connection and refresh", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
		
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	//MARK: Refresh Data
	
	func refreshData(){
		viewModel?.refreshData(tableView.reloadData())
	}
	
	//MARK: TableView Functions
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		self.selectedIndex = indexPath.row
		if (!Reachability.isConnectedToNetwork()){
			showOfflineIndicator()
			//TODO: Make offline page of abstract and title, pass that as next URL
			return
		}
		self.performSegueWithIdentifier("showStory", sender: self)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("storyCell", forIndexPath: indexPath) as! storyCell

		//cell.setTestText("index is " + String(indexPath.row))
		cell.setTestText(viewModel!.getStoryAtIndex(indexPath.row).title!)
		cell.setPreviewPicture(viewModel!.getImageAtIndex(indexPath.row, indicatorStart: (), indicatorStop: ()))
		cell.setSubTitle(viewModel!.getStoryAtIndex(indexPath.row).contentSnippet!)
		
		return cell
		
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let numberStories = viewModel!.getNumberOfStories()
		if (numberStories>0){
			if(viewModel?.isConnected == false){
				showOfflineIndicator()
			}
			return numberStories
		}
			
		else{
			showOfflineIndicator()
			return 0
		}
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "showStory"){
			
			let nextStoryVC = segue.destinationViewController as! storyVC
			let url = viewModel!.getLinkAtIndex(selectedIndex)
			nextStoryVC.assignViewModel(storyVM(url: url,isOff: false))
			
		}
	}

}

