//
//  SvgaPlaygroundView.swift
//
//
//  Created by Nerd Just on 2024/12/17.
//

import Cocoa
import WebKit

class SvgaPlaygroundView: NSView {
    
    lazy var webView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
        loadWebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        wantsLayer = true
        
        addSubview(webView)
        webView.frame = bounds
    }

    private func loadWebView() {

        guard let resourceURL = (NSApplication.shared.delegate as! AppDelegate).resourceURL else {
            fatalError("resource url is nil!")
        }
        
        guard let bundlePath = Bundle.main.executablePath else {
            fatalError("Bundle path is not exist!")
        }
        
        let bundleURL = URL(fileURLWithPath: bundlePath)
        let htmlFilePath = bundleURL.deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("index.html")
        
        do {
            var htmlContent = try String(contentsOf: htmlFilePath, encoding: .utf8)
            htmlContent = htmlContent.replacingOccurrences(of: "___src_url___", with: resourceURL)
            webView.loadHTMLString(htmlContent, baseURL: nil)
        } catch {
            fatalError("Error reading HTML file: \(error). Looked for file at: \(htmlFilePath.path)")
        }
    }
}
