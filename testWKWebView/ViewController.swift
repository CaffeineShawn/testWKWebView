//
//  ViewController.swift
//  testWKWebView
//
//  Created by ByteDance on 2024/4/7.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create WKWebView instance
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())

        // Load HTML page using HTTPS URL request
        if let url = URL(string: "https://www.baidu.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        webView.navigationDelegate = self

        // Button to present WebViewController modally
        let presentButton = UIButton(type: .system)
        presentButton.setTitle("Present Web View", for: .normal)
        presentButton.addTarget(self, action: #selector(presentWebView), for: .touchUpInside)
        view.addSubview(presentButton)

        // Set button constraints
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Button to present WebViewController modally
        let presentAnotherButton = UIButton(type: .system)
        presentAnotherButton.setTitle("Present Another Web View", for: .normal)
        presentAnotherButton.addTarget(self, action: #selector(presentAnotherWebView), for: .touchUpInside)
        view.addSubview(presentAnotherButton)

        // Set button constraints
        presentAnotherButton.translatesAutoresizingMaskIntoConstraints = false
        presentAnotherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentAnotherButton.centerYAnchor.constraint(equalTo: presentButton.centerYAnchor, constant: 40).isActive = true
    }

    @objc func presentWebView() {
        let webViewController = WebViewController()
        webViewController.webView = self.webView
        present(webViewController, animated: true, completion: nil)
    }
    
    fileprivate func callDeadLockJS(_ _webView: WKWebView) {
        // Call evaluateJavaScript
        let jsCode = """
            function lock() {
                while (1) {}
            }
            lock()
        """
        _webView.evaluateJavaScript(jsCode) { (result, error) in
            if let error = error {
                print("Error executing JavaScript: \(error.localizedDescription)")
            } else {
                print("JavaScript executed successfully")
            }
        }
    }
    
    @objc func presentAnotherWebView() {
        let webViewController = WebViewController()
        // Create WKWebView instance
        let _webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        _webView.navigationDelegate = self
        // Load HTML page using HTTPS URL request
        if let url = URL(string: "https://www.baidu.com") {
            let request = URLRequest(url: url)
            _webView.load(request)
        }
        webViewController.webView = _webView
        present(webViewController, animated: true, completion: nil)
    }
    
    // MARK: WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Web view did commit navigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web view navigation finished")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Web view navigation failed with error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Web view provisional navigation failed with error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Web view started provisional navigation")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("Web view received server redirect for provisional navigation")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("Web content process did terminate")
    }
}


class WebViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create WKWebView instance
        view.addSubview(webView)

        // Load HTML page using HTTPS URL request
        if let url = URL(string: "https://example.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        // Set constraints for WKWebView
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
