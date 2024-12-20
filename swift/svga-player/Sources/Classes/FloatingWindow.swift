//
//  FloatingWindow.swift
//
//
//  Created by Nerd Just on 2024/12/17.
//

import Cocoa

class FloatingWindow: NSPanel {
    
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        defaultConfig()
        initUI()
    }
    
    private func defaultConfig() {
        backgroundColor = .clear
        isOpaque = false
        hasShadow = false
        level = .floating
    }
    
    private func initUI() {
        createBackgroundView()
        createContentView()
        makeKeyAndOrderFront(nil)
    }
    
    private func createBackgroundView() {
        let contentView = NSView()
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.gray.withAlphaComponent(0.5).cgColor
        self.contentView = contentView
    }
    
    private func createContentView() {
        let x = ((self.contentView?.bounds.width ?? 1000) - 500) / 2
        let y = ((self.contentView?.bounds.height ?? 1000) - 500) / 2
        
        let webView = SvgaPlaygroundView(frame: CGRect(x: x, y: y, width: 500, height: 500))
        self.contentView?.addSubview(webView)
    }
    
}
