//
//  WebViewController.swift
//  NewsAssignment
//
//  Created by Marketgoal on 20/04/18.
//  Copyright © 2018 Marketgoal. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    var selectedUrl: String = "Anonymous"

    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        let url = NSURL(string: selectedUrl)
        let request = NSURLRequest(url: url! as URL)
        
        webView.delegate = self
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        webView.loadRequest(request as URLRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func doRefresh(_: AnyObject) {
        webView.reload()
    }
    
    @IBAction func goBack(_: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func goForward(_: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func stop(_: AnyObject) {
        webView.stopLoading()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
