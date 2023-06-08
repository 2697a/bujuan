//
//  ToolbarNameToEnumConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 27.11.22.
//

import Foundation

class ToolbarStyleNameToEnumConverter {
    @available(macOS 11.0, *)
    public static func getToolbarStyleFromName(name: String) -> NSWindow.ToolbarStyle? {
        switch (name) {
        case "automatic":
            return NSWindow.ToolbarStyle.automatic
            
        case "expanded":
            return NSWindow.ToolbarStyle.expanded
            
        case "preference":
            return NSWindow.ToolbarStyle.preference
            
        case "unified":
            return NSWindow.ToolbarStyle.unified
            
        case "unifiedCompact":
            return NSWindow.ToolbarStyle.unifiedCompact
        
        default:
            return nil
        }
    }
}
