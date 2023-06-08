//
//  MainFlutterWindowManipulator.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 21.10.22.
//

import Foundation
import FlutterMacOS

public class MainFlutterWindowManipulator {
    private static var mainFlutterWindow: NSWindow?
    private static var mainFlutterWindowDelegate: FlutterWindowDelegate?
    
    private static func printNotStartedWarning() {
        print("Warning: The MainFlutterWindowManipulator has not been started. Please make sure the macos_window_utils plugin is initialized correctly in your MainFlutterWindow.swift file.")
    }
    
    private static func configureMainFlutterWindow(_ mainFlutterWindow: NSWindow) {
        let windowFrame = mainFlutterWindow.frame
        let flutterViewController = mainFlutterWindow.contentViewController as! FlutterViewController
        let macOSWindowUtilsViewController = MacOSWindowUtilsViewController(flutterViewController: flutterViewController) // new
        mainFlutterWindow.contentViewController = macOSWindowUtilsViewController // new
         mainFlutterWindow.minSize = NSSize(width: 1080, height: 720)
         mainFlutterWindow.setContentSize(NSSize(width: 1080, height: 720))
        mainFlutterWindow.setFrame(windowFrame, display: true)
    }
    
    public static func start(mainFlutterWindow: NSWindow?) {
        let isProvidedWindow = mainFlutterWindow != nil
        let mainFlutterWindow = mainFlutterWindow ?? NSApp.windows.first
        
        if (mainFlutterWindow == nil) {
            printNotStartedWarning()
            return
        }
        
        self.mainFlutterWindow = mainFlutterWindow
        
        if (!isProvidedWindow) {
            configureMainFlutterWindow(mainFlutterWindow!)
        }
        
        showTitle()
        makeTitlebarOpaque()
        disableFullSizeContentView()
        setWindowBackgroundColorToDefaultColor()
    }
    
    public static func createFlutterWindowDelegate(methodChannel: FlutterMethodChannel) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        mainFlutterWindowDelegate = FlutterWindowDelegate.create(window: mainFlutterWindow!, methodChannel: methodChannel)
    }
    
    public static func hideTitle() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.titleVisibility = NSWindow.TitleVisibility.hidden
    }
    
    public static func showTitle() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.titleVisibility = NSWindow.TitleVisibility.visible
    }
    
    public static func makeTitlebarTransparent() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.titlebarAppearsTransparent = true
    }
    
    public static func makeTitlebarOpaque() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.titlebarAppearsTransparent = false
    }
    
    public static func enableFullSizeContentView() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.styleMask.insert(.fullSizeContentView)
    }
    
    public static func disableFullSizeContentView() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.styleMask.remove(.fullSizeContentView)
    }
    
    public static func zoomWindow() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.setIsZoomed(true)
    }
    
    public static func unzoomWindow() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.setIsZoomed(false)
    }
    
    public static func isWindowZoomed() -> Bool {
        if (self.mainFlutterWindow == nil) {
            printNotStartedWarning()
            return false
        }
        
        return self.mainFlutterWindow!.isZoomed
    }
    
    public static func enterFullscreen() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        if (!isWindowFullscreened()) {
            self.mainFlutterWindow!.toggleFullScreen(self)
        }
    }
    
    public static func exitFullscreen() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        if (isWindowFullscreened()) {
            self.mainFlutterWindow!.toggleFullScreen(self)
        }
    }
    
    public static func isWindowFullscreened() -> Bool {
        if (self.mainFlutterWindow == nil) {
            printNotStartedWarning()
            return false
        }
        
        let isFullscreenEnabled = self.mainFlutterWindow!.styleMask.contains(NSWindow.StyleMask.fullScreen)
        return isFullscreenEnabled
    }
    
    public static func hideZoomButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.zoomButton)!.isHidden = true
    }
    
    public static func showZoomButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.zoomButton)!.isHidden = false
    }
    
    public static func hideMiniaturizeButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.miniaturizeButton)!.isHidden = true
    }
    
    public static func showMiniaturizeButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.miniaturizeButton)!.isHidden = false
    }
    
    public static func hideCloseButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.closeButton)!.isHidden = true
    }
    
    public static func showCloseButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.closeButton)!.isHidden = false
    }
    
    public static func enableZoomButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.zoomButton)!.isEnabled = true
    }

    public static func disableZoomButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.zoomButton)!.isEnabled = false
    }

    public static func enableMiniaturizeButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.miniaturizeButton)!.isEnabled = true
    }

    public static func disableMiniaturizeButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.miniaturizeButton)!.isEnabled = false
    }

    public static func enableCloseButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.closeButton)!.isEnabled = true
    }

    public static func disableCloseButton() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.standardWindowButton(.closeButton)!.isEnabled = false
    }
    
    public static func setDocumentEdited() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.isDocumentEdited = true
    }
    
    public static func setDocumentUnedited() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.isDocumentEdited = false
    }
    
    public static func setRepresentedFilename(filename: String) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.representedFilename = filename
    }
    
    public static func setRepresentedURL(url: String) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.representedURL = URL(string: url)
    }
    
    public static func isWindowInLiveResize() -> Bool {
        if (self.mainFlutterWindow == nil) {
            printNotStartedWarning()
            return false
        }
        
        return self.mainFlutterWindow!.inLiveResize
    }
    
    public static func setWindowAlphaValue(alphaValue: CGFloat) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.alphaValue = alphaValue
    }
    
    public static func isWindowVisible() -> Bool {
        if (self.mainFlutterWindow == nil) {
            printNotStartedWarning()
            return false
        }
        
        return self.mainFlutterWindow!.isVisible
    }
    
    public static func setWindowBackgroundColorToDefaultColor() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.backgroundColor = .windowBackgroundColor
    }
    
    public static func setWindowBackgroundColorToClear() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.backgroundColor = .clear
    }
    
    public static func setNSVisualEffectViewState(state: NSVisualEffectView.State) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow?.contentViewController as! MacOSWindowUtilsViewController;
        (macOSWindowUtilsViewController.view as! NSVisualEffectView).state = state
    }
    
    @available(macOS 10.14, *)
    public static func setAppearance(dark: Bool) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.contentView?.superview?.appearance = NSAppearance(named: dark ? .darkAqua : .aqua)
        
        self.mainFlutterWindow!.invalidateShadow()
    }
    
    @available(macOS 10.14, *)
    public static func setMaterial(material: NSVisualEffectView.Material) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow!.contentViewController as! MacOSWindowUtilsViewController;
        (macOSWindowUtilsViewController.view as! NSVisualEffectView).material = material
        
        self.mainFlutterWindow!.invalidateShadow()
    }
    
    public static func getTitlebarHeight() -> CGFloat {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let windowFrameHeight = (self.mainFlutterWindow!.contentView?.frame.height)!
        let contentLayoutRectHeight = self.mainFlutterWindow!.contentLayoutRect.height
        let fullSizeContentViewNoContentAreaHeight = windowFrameHeight - contentLayoutRectHeight
        return fullSizeContentViewNoContentAreaHeight
    }
    
    public static func addVisualEffectSubview(_ visualEffectSubview: VisualEffectSubview) -> UInt {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow?.contentViewController as! MacOSWindowUtilsViewController;
        return macOSWindowUtilsViewController.addVisualEffectSubview(visualEffectSubview)
    }
    
    public static func getVisualEffectSubview(_ subviewId: UInt) -> VisualEffectSubview? {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow?.contentViewController as! MacOSWindowUtilsViewController;
        return macOSWindowUtilsViewController.getVisualEffectSubview(subviewId)
    }
    
    public static func removeVisualEffectSubview(_ subviewId: UInt) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow?.contentViewController as! MacOSWindowUtilsViewController;
        macOSWindowUtilsViewController.removeVisualEffectSubview(subviewId)
    }
    
    public static func addToolbar() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        if #available(macOS 10.13, *) {
            let newToolbar = NSToolbar()

            self.mainFlutterWindow!.toolbar = newToolbar
        }
    }
    
    public static func removeToolbar() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.toolbar = nil
    }
    
    @available(macOS 11.0, *)
    public static func setToolbarStyle(toolbarStyle: NSWindow.ToolbarStyle) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.toolbarStyle = toolbarStyle
    }
    
    public static func enableShadow() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.hasShadow = true
    }
    
    public static func disableShadow() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.hasShadow = false
    }
    
    public static func invalidateShadows() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.invalidateShadow()
    }
    
    public static func addEmptyMaskImage() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow!.contentViewController as! MacOSWindowUtilsViewController;
        (macOSWindowUtilsViewController.view as! NSVisualEffectView).maskImage = NSImage()
    }
    
    public static func removeMaskImage() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        let macOSWindowUtilsViewController = self.mainFlutterWindow!.contentViewController as! MacOSWindowUtilsViewController;
        (macOSWindowUtilsViewController.view as! NSVisualEffectView).maskImage = nil
    }
    
    public static func ignoreMouseEvents() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.ignoresMouseEvents = true
    }
    
    public static func acknowledgeMouseEvents() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.ignoresMouseEvents = false
    }
    
    @available(macOS 11.0, *)
    public static func setSubtitle(_ subtitle: String) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.subtitle = subtitle
    }
    
    public static func setLevel(_ level: NSWindow.Level) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.level = level
    }
    
    public static func orderOut() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.orderOut(nil)
    }
    
    public static func orderBack() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.orderBack(nil)
    }
    
    
    public static func orderFront() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.orderFront(nil)
    }
    
    public static func orderFrontRegardless() {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.orderFrontRegardless()
    }
    
    public static func insertIntoStyleMask(_ styleMask: NSWindow.StyleMask) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.styleMask.insert(styleMask)
    }
    
    public static func removeFromStyleMask(_ styleMask: NSWindow.StyleMask) {
        if (self.mainFlutterWindow == nil) {
            start(mainFlutterWindow: nil)
        }
        
        self.mainFlutterWindow!.styleMask.remove(styleMask)
    }
    
    public static func removeFullScreenPresentationOptions() -> Bool {
        if (mainFlutterWindowDelegate == nil) {
            return false
        }
        
        mainFlutterWindowDelegate!.removeFullScreenPresentationOptions()
        return true
    }
    
    public static func addFullScreenPresentationOptions(_ presentationOptions: NSApplication.PresentationOptions) -> Bool {
        if (mainFlutterWindowDelegate == nil) {
            return false
        }
        
        mainFlutterWindowDelegate?.addFullScreenPresentationOptions(presentationOptions)
        return true
    }
}
