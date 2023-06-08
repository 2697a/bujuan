//
//  VisualEffectSubview.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 21.10.22.
//

import Foundation

public class VisualEffectSubview: NSVisualEffectView {
    public override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
}
