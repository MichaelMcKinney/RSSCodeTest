//
//  scrollListVC.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import UIKit

class scrollListVC: UIViewController, UIScrollViewDelegate{
	
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var refreshButton: UIButton!
	@IBOutlet var indexLabel: UILabel!
	
	var viewModel: listVM?
	var selectedIndex = 0
	
	var pageViews: [storyCardView?] = []

	
//MARK: Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.assignViewModel(listVM())
		setupTouchRecognizer()
		setupRefreshButton()
		updateLabel()
		
		var i = 0
		while(i<viewModel!.getNumberOfStories()){
			pageViews.append(nil)
			i++
		}
		
		let pagesScrollViewSize = scrollView.frame.size
		
		scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat((viewModel!.getNumberOfStories())), pagesScrollViewSize.height)
		
		
		loadVisiblePages()
	}
	
	override func viewWillAppear(animated: Bool) {
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if (Reachability.isConnectedToNetwork() == false){
			showOfflineIndicator()
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func assignViewModel(tempViewModel: listVM){
		self.viewModel = tempViewModel
	}
	
	private func setupRefreshButton(){
		refreshButton.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.TouchUpInside)
	}
	
	private func updateLabel(){
		let pageWidth = scrollView.frame.size.width
		let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))

		let max = viewModel!.getNumberOfStories()
		
		indexLabel.text = String(page+1) + " / " + String(max)
	}
	
//MARK: Offline Indicator
	
	func showOfflineIndicator(){
		
		let alert = UIAlertController(title: "Offline", message: "Cannot load new stories. Check Network connection and refresh", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
		
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
//MARK: Refresh Data
	
	func refreshData(){
		
		if (Reachability.isConnectedToNetwork() == false){
			showOfflineIndicator()
		}
		
		print("DID REFRESH")
		
		viewModel?.refreshData(purgeAllCells())
	}
	
//MARK: ScrollView Pages
	
	func purgeAllCells(){
		var i = 0
		while(i<viewModel!.getNumberOfStories()){
			pageViews.append(nil)
			i++
		}
		loadVisiblePages()
	}
	
	func loadVisiblePages() {
		
		let pageWidth = scrollView.frame.size.width
		let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
		
		// Work out which pages you want to load
		let firstPage = page - 1
		let lastPage = page + 1
		
		// Purge anything before the first page
		for var index = 0; index < firstPage; ++index {
			purgePage(index)
		}
		
		// Load pages in our range
		for index in firstPage...lastPage {
			loadPage(index)
		}
		
		// Purge anything after the last page
		for var index = lastPage+1; index < viewModel!.getNumberOfStories(); ++index {
			purgePage(index)
		}
	}
	
	func loadPage(index: Int) {
		let max = viewModel!.getNumberOfStories()
		
		if (index < 0 || index >= max) {
		// If it's outside the range of what you have to display, then do nothing
			return
		}
		
		// Load an individual page, first checking if you've already loaded it
		if let _ = pageViews[index] { // Checks to see if cell is empty

			// Do nothing. The view is already loaded.
			
		}
			
		else {
			var frame = scrollView.bounds
			frame.origin.x = frame.size.width * CGFloat(index)
			frame.origin.y = 0.0
			frame = CGRectInset(frame, 15.0, 0.0)
 
			let newPageView = storyCardView.instanceFromNib() as! storyCardView
			
			
			newPageView.setMainText(viewModel!.getStoryAtIndex(index).title!)
			newPageView.setSubTitle(viewModel!.getStoryAtIndex(index).contentSnippet!)
			newPageView.setPreviewPicture(viewModel!.getImageAtIndex(index))
			
			newPageView.contentMode = .ScaleAspectFit
			newPageView.frame = frame
			scrollView.addSubview(newPageView)
			pageViews[index] = newPageView
			print("MADE NEW CELL")
		}
	}
	
	func purgePage(index: Int) {
		if index < 0 || index >= viewModel!.getNumberOfStories() {
		// If it's outside the range of what you have to display, then do nothing
			return
		}
		
		// Remove a page from the scroll view and reset the container array
		if let currentView = pageViews[index] {
			currentView.removeFromSuperview()
			pageViews[index] = nil
		}
	}
	
//MARK: ScrollView Functionality
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		loadVisiblePages()
		updateLabel()
	}
	
//MARK: Segues
	func setupTouchRecognizer(){
		let singleTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "singleTap")
		singleTapGestureRecognizer.numberOfTapsRequired = 1;
		singleTapGestureRecognizer.enabled = true;
		singleTapGestureRecognizer.cancelsTouchesInView = false;
		scrollView.addGestureRecognizer(singleTapGestureRecognizer)
	}
	
	func singleTap(){
		let pageWidth = scrollView.frame.size.width
		let index = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
		
		self.selectedIndex = index
		
		if (!Reachability.isConnectedToNetwork()){
			showOfflineIndicator()
			//TODO: Make offline page of abstract and title, pass that as next URL
			return
		}
		
		self.performSegueWithIdentifier("showStory", sender: self)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "showStory"){
			
			let nextStoryVC = segue.destinationViewController as! storyVC
			let url = viewModel!.getURLAtIndex(selectedIndex)
			nextStoryVC.assignViewModel(storyVM(url: url))
			
		}

	}

	
	
	
	
	
	
}
