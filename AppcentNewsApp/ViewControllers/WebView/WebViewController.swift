//
//  WebViewController.swift
//  AppcentNewsApp
//
//  Created by Tayfur Salih Şen on 8.07.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak private var webView: WKWebView!
    private let websiteUrl: String
    
    init(websiteUrl: String) {
        self.websiteUrl = websiteUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Source"
        setUpNavigaitonBar()
        manageWebView()
    }
}

// MARK: - Private Functions
private extension WebViewController {
    func manageWebView() {
        webView.uiDelegate = self
        let myURL = URL(string: websiteUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func setUpNavigaitonBar() {
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}
