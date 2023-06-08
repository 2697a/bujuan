//
//  FlutterWindowDelegate.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 24.02.23.
//

import Foundation
import FlutterMacOS

class FlutterWindowDelegate: NSObject, NSWindowDelegate {
    private var methodChannel: FlutterMethodChannel?
    private var fullScreenPresentationOptions: NSApplication.PresentationOptions?
    
    public static func create(window: NSWindow, methodChannel: FlutterMethodChannel) -> FlutterWindowDelegate {
        let newDelegate = FlutterWindowDelegate()
        newDelegate.methodChannel = methodChannel
        window.delegate = newDelegate
        return newDelegate
    }
    
    public func removeFullScreenPresentationOptions() {
        fullScreenPresentationOptions = nil
    }
    
    public func addFullScreenPresentationOptions(_ presentationOptions: NSApplication.PresentationOptions) {
        if (fullScreenPresentationOptions == nil) {
            fullScreenPresentationOptions = presentationOptions
            return
        }
        
        fullScreenPresentationOptions!.insert(presentationOptions)
    }
    
    // Managing Sheets
        
    func windowWillBeginSheet(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillBeginSheet", arguments: nil)
    }

    func windowDidEndSheet(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidEndSheet", arguments: nil)
    }

    // Sizing Windows

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        let arguments = sizeToDictionary(frameSize)
        methodChannel!.invokeMethod("windowWillResize", arguments: arguments)
        return frameSize
    }

    func windowDidResize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidResize", arguments: nil)
    }

    func windowWillStartLiveResize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillStartLiveResize", arguments: nil)
    }

    func windowDidEndLiveResize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidEndLiveResize", arguments: nil)
    }

    // Minimizing Windows

    func windowWillMiniaturize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillMiniaturize", arguments: nil)
    }

    func windowDidMiniaturize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidMiniaturize", arguments: nil)
    }

    func windowDidDeminiaturize(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidDeminiaturize", arguments: nil)
    }

    // Zooming Window

    func windowWillUseStandardFrame(_ window: NSWindow, defaultFrame newFrame: NSRect) -> NSRect {
        let arguments = rectToDictionary(newFrame)
        methodChannel!.invokeMethod("windowWillUseStandardFrame", arguments: arguments)
        return newFrame
    }

    func windowShouldZoom(_ window: NSWindow, toFrame newFrame: NSRect) -> Bool {
        let arguments = rectToDictionary(newFrame)
        methodChannel!.invokeMethod("windowShouldZoom", arguments: arguments)
        return true
    }

    // Managing Full-Screen Presentation
    
    func window(_ window: NSWindow, willUseFullScreenPresentationOptions proposedOptions: NSApplication.PresentationOptions = []) -> NSApplication.PresentationOptions {
        return fullScreenPresentationOptions ?? proposedOptions
    }

    func windowWillEnterFullScreen(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillEnterFullScreen", arguments: nil)
    }

    func windowDidEnterFullScreen(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidEnterFullScreen", arguments: nil)
    }

    func windowWillExitFullScreen(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillExitFullScreen", arguments: nil)
    }

    func windowDidExitFullScreen(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidExitFullScreen", arguments: nil)
    }

    // Custom Full-Screen Presentation Animations

    // (not implemented)

    // Moving Windows

    func windowWillMove(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillMove", arguments: nil)
    }

    func windowDidMove(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidMove", arguments: nil)
    }

    func windowDidChangeScreen(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidChangeScreen", arguments: nil)
    }

    func windowDidChangeScreenProfile(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidChangeScreenProfile", arguments: nil)
    }

    func windowDidChangeBackingProperties(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidChangeBackingProperties", arguments: nil)
    }

    // Closing Windows

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        methodChannel!.invokeMethod("windowShouldClose", arguments: nil)
        return true
    }

    func windowWillClose(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillClose", arguments: nil)
    }

    // Managing Key Status

    func windowDidBecomeKey(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidBecomeKey", arguments: nil)
    }

    func windowDidResignKey(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidResignKey", arguments: nil)
    }

    // Managing Main Status

    func windowDidBecomeMain(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidBecomeMain", arguments: nil)
    }

    func windowDidResignMain(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidResignMain", arguments: nil)
    }

    // Managing Field Editors

    // (not implemented)

    // Updating Windows

    // (not implemented)

    // Exposing Windows

    func windowDidExpose(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidExpose", arguments: nil)
    }

    // Managing Occlusion State

    func windowDidChangeOcclusionState(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidChangeOcclusionState", arguments: nil)
    }

    // Dragging Windows

    // (not implemented)

    // Getting the Undo Manager

    // (not implemented)

    // Managing Titles

    // (not implemented)

    // Managing Restorable State

    // (not implemented)

    // Managing Presentation in Version Browsers

    func windowWillEnterVersionBrowser(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillEnterVersionBrowser", arguments: nil)
    }

    func windowDidEnterVersionBrowser(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidEnterVersionBrowser", arguments: nil)
    }

    func windowWillExitVersionBrowser(_ notification: Notification) {
        methodChannel!.invokeMethod("windowWillExitVersionBrowser", arguments: nil)
    }

    func windowDidExitVersionBrowser(_ notification: Notification) {
        methodChannel!.invokeMethod("windowDidExitVersionBrowser", arguments: nil)
    }
    
    
    private func sizeToDictionary(_ size: NSSize) -> NSDictionary {
        return [
            "width" : size.width,
            "height" : size.height
        ]
    }
    
    private func rectToDictionary(_ rect: NSRect) -> NSDictionary {
        return [
            "x" : rect.minX,
            "y" : rect.minY,
            "w" : rect.width,
            "h" : rect.height
        ]
    }
}
