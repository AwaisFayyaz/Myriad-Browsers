//
//  ExpandedWebViewController.swift
//  Browsed
//
//  Created by MacBook on 1/12/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import UIKit
import WebKit

class ExpandedWebViewController: UIViewController {

    @IBOutlet weak var browserWebView: WKWebView!
    @IBOutlet weak var urlTextField: UITextField!
    
    lazy var urlString = ""
    var cookies: [HTTPCookie]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cookies = cookies else { return }
        for cookie in cookies {
            browserWebView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: nil)
        }
        setupViews()
    }
    
    private func setupViews(){
        
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        browserWebView.allowsBackForwardNavigationGestures = true
        browserWebView.load(urlRequest)
        urlTextField.text = urlString
        
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        browserWebView.goBack()
        
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        
        browserWebView.goForward()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        
        browserWebView.reload()
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
