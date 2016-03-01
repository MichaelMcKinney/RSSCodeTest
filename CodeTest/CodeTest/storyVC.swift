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
	
	var viewModel = storyVM(url: NSURL())
	var allowLoad = true
	
	@IBOutlet var webView: UIWebView!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	
	@IBOutlet var xButton: UIButton!
	//MARK: Initialization
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupWebView()
		setupButton()

	}
	
	private func setupWebView(){
		let baseURL = NSURLRequest(URL: viewModel.URL)
		webView.loadRequest(baseURL)
	}
	
	func setupButton(){
		xButton.addTarget(self, action: "didClick", forControlEvents: UIControlEvents.TouchUpInside)
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