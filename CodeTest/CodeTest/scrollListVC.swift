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
	
	var pageViews: [storyCardView?] = []

	
//MARK: Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.assignViewModel(listVM())
		
		var i = 0
		while(i<viewModel?.getNumberOfStories()){
			pageViews.append(nil)
			i++
		}
		
		let pagesScrollViewSize = scrollView.frame.size
		
		scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat((viewModel?.getNumberOfStories())!), pagesScrollViewSize.height)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
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
		//TODO: make a refresh function to regenerate the data in the cells
		//viewModel?.refreshData(tableView.reloadData())
	}
	
//MARK: ScrollView Pages
	
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
		// Purge anything after the last page
		for var index = lastPage+1; index < viewModel?.getNumberOfStories(); ++index {
			purgePage(index)
		}
	}
	
	func loadPage(index: Int) {
		
		if (index < 0 || index >= viewModel?.getNumberOfStories()) {
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
			frame = CGRectInset(frame, 10.0, 0.0)
 
			let newPageView = storyCardView()

			newPageView.setMainText((viewModel?.getStoryAtIndex(index).title)!)
			newPageView.setSubTitle((viewModel?.getStoryAtIndex(index).contentSnippet)!)
			newPageView.setPreviewPicture((viewModel?.getImageAtIndex(index))!)
			
			newPageView.contentMode = .ScaleAspectFit
			newPageView.frame = frame
			scrollView.addSubview(newPageView)
			pageViews[index] = newPageView
		}
	}
	
	func purgePage(index: Int) {
		if index < 0 || index >= viewModel?.getNumberOfStories() {
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
	}

	
	
	
	
	
	
}
