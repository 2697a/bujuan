//
//  MacOSWindowUtilsViewController.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 21.10.22.
//

import Foundation
import FlutterMacOS

public class MacOSWindowUtilsViewController: NSViewController {
    private var _flutterViewController : FlutterViewController? = nil;
    public var flutterViewController: FlutterViewController {
        get { return _flutterViewController! }
    }
    private var visualEffectSubviewRegistry = VisualEffectSubviewRegistry()

    public init(flutterViewController: FlutterViewController? = nil) {
        self._flutterViewController = flutterViewController ?? FlutterViewController()
        
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError()
    }

    override public func loadView() {
        let newVisualEffectView = NSVisualEffectView()
        newVisualEffectView.autoresizingMask = [.width, .height]
        newVisualEffectView.blendingMode = .behindWindow
        newVisualEffectView.state = .followsWindowActiveState
        if #available(macOS 10.14, *) {
            newVisualEffectView.material = .windowBackground
        }
        self.view = newVisualEffectView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(flutterViewController)

        flutterViewController.view.frame = self.view.bounds
        flutterViewController.view.autoresizingMask = [.width, .height]
        
        // Since Flutter 3.7.0 the FlutterViewController's background is black by default and therefore needs to be set to clear.
        flutterViewController.backgroundColor = .clear
        
        self.view.addSubview(flutterViewController.view)
    }
    
    public func addVisualEffectSubview(_ visualEffectSubview: VisualEffectSubview) -> UInt {
        self.view.addSubview(visualEffectSubview, positioned: .below, relativeTo: flutterViewController.view)
        return visualEffectSubviewRegistry.registerSubview(visualEffectSubview)
    }
    
    public func getVisualEffectSubview(_ subviewId: UInt) -> VisualEffectSubview? {
        return visualEffectSubviewRegistry.getSubviewFromId(subviewId)
    }
    
    public func removeVisualEffectSubview(_ subviewId: UInt) {
        let visualEffectSubview = visualEffectSubviewRegistry.getSubviewFromId(subviewId)
        visualEffectSubview?.removeFromSuperview()
        visualEffectSubviewRegistry.deregisterSubview(subviewId)
    }
}
