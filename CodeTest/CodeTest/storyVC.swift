//
//  storyVC.swift
//  CodeTest
//
//  Created by Michael McKinney on 3/1/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import Foundation
import UIKit

class storyVC: UIViewController, UIWebViewDelegate{
	
	var viewModel = storyVM(url: "",isOff: true)
	var allowLoad = true
	
	@IBOutlet var webView: UIWebView!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	
	@IBOutlet var buttonView: UIView!
	@IBOutlet var xButton: UIButton!
	//MARK: Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupWebView()
		setupButton()

	}
	
	private func setupWebView(){
		if (viewModel.isOffline){
			//load from HTML
			webView.loadHTMLString(viewModel.URL, baseURL: nil)
		}
			
		else{
			//load request
			let baseURL = NSURLRequest(URL: NSURL(string: viewModel.URL)!)
			webView.loadRequest(baseURL)
		}

	}
	
	func setupButton(){
		xButton.addTarget(self, action: "didClick", forControlEvents: UIControlEvents.TouchUpInside)
		
		buttonView.layer.cornerRadius = 8
		buttonView.layer.borderWidth = 1
		buttonView.layer.borderColor = UIColor.lightGrayColor().CGColor
		buttonView.clipsToBounds = true
		
		buttonView.layer.shadowColor = UIColor.lightGrayColor().CGColor
		buttonView.layer.shadowOffset = CGSizeMake(-0.2, -0.2)
		buttonView.layer.shadowRadius = 1
		buttonView.layer.shadowPath = UIBezierPath(rect: buttonView.bounds).CGPath
		buttonView.layer.shadowOpacity = 0.2

	}
	
	func didClick(){
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	func assignViewModel(tempViewModel: storyVM){
		
		self.viewModel = tempViewModel
	}
	
	//MARK: Webview
	
	func webViewDidStartLoad(webView: UIWebView) {
		activityIndicator.startAnimating()
	}
	
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		return allowLoad
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		allowLoad = false
		activityIndicator.stopAnimating()
	}
	
	
}