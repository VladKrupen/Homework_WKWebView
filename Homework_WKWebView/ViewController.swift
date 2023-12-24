//
//  ViewController.swift
//  Homework_WKWebView
//
//  Created by Vlad on 24.12.23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView()
    
    let url = URL(string: "https://google.com")!
    
    let bottomToolbar = UIToolbar()
    
    let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"))
    let forwardButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"))
    let safariButtonItem = UIBarButtonItem(image: UIImage(systemName: "safari"))
    let space = UIBarButtonItem(systemItem: .flexibleSpace)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBottomToolbar()
        setupWebView()
        
        

    }
    
    func setupWebView() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        webView.load(URLRequest(url: url))
        
        webView.navigationDelegate = self
    }
    
    func setupBottomToolbar() {
        
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomToolbar)
        
        NSLayoutConstraint.activate([
            bottomToolbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomToolbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        bottomToolbar.items = [backButtonItem, space, forwardButtonItem, space, space, safariButtonItem]
        
        backButtonItem.action = #selector(backButtonItemTapped)
        forwardButtonItem.action = #selector(forwardButtonItemTapped)
        safariButtonItem.action = #selector(safariButtonItemTapped)
        
        
    }
    
    //MARK: - Actions of the bottomToolbar buttons
    
    @objc func backButtonItemTapped() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    @objc func forwardButtonItemTapped() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    
    @objc func safariButtonItemTapped() {
        UIApplication.shared.open(url)
    }

    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButtonItem.isEnabled = webView.canGoBack
        forwardButtonItem.isEnabled = webView.canGoForward
    }

}

