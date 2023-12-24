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
    
    let topToolBar = UIToolbar()
    
    let updateButtonItem = UIBarButtonItem(systemItem: .refresh)
    
    let searchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBottomToolbar()
        setupTopToolbar()
        setupWebView()
        
        

    }
    
    //MARK: - Setup WebView
    
    func setupWebView() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topToolBar.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        webView.load(URLRequest(url: url))
        
        webView.navigationDelegate = self
    }
    
    //MARK: - Setup BottomToolbar
    
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
    
    //MARK: - Setup TopToolbar
    
    func setupTopToolbar() {
        
        topToolBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topToolBar)
        
        NSLayoutConstraint.activate([
            topToolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topToolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topToolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        topToolBar.items = [space, UIBarButtonItem(customView: searchBar), space, updateButtonItem]
        
        updateButtonItem.action = #selector(updateButtonItemTapped)
        
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
    
    //MARK: - Action of the topToolbar button
    
    @objc func updateButtonItemTapped() {
        webView.reload()
    }

    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButtonItem.isEnabled = webView.canGoBack
        forwardButtonItem.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        searchBar.text = webView.url?.absoluteString
    }

}

