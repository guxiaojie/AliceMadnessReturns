//
//  DetailViewController.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/12.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var articleWebView: WKWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    func configureView() {
        if let sourURL = sourURL{
            if let articleWebView = articleWebView {
                articleWebView.navigationDelegate = self
                articleWebView.load(URLRequest(url: URL(string: sourURL)!))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var sourURL: String? {
        didSet {
            configureView()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.isHidden = true
    }
    
}

