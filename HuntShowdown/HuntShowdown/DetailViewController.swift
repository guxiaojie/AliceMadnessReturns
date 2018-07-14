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

    var indicatorView: UIActivityIndicatorView!
    var webView: WKWebView!
    
    //Backwards Compatible - use loadView
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }
    
    func configureView() {
        if let sourURL = sourURL{
            if let articleWebView = webView {
                articleWebView.navigationDelegate = self
                articleWebView.load(URLRequest(url: URL(string: sourURL)!))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2, width: 20, height: 20)
//        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let indicatorView = indicatorView{
            indicatorView.isHidden = true
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let indicatorView = indicatorView{
            indicatorView.isHidden = true
        }
    }
    
}

