//
//  BrowserTableViewCell.swift
//  Browsed
//
//  Created by MacBook on 1/11/20.
//  Copyright © 2020 Khalis Group. All rights reserved.
//

import UIKit
import WebKit

class BrowserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var browserWebView: WKWebView!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var duplicateBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var containerWebView: UIView!
    var webView = WKWebView()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
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
    
}
extension BrowserTableViewCell: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("did start navigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish navigation")
    }
}
