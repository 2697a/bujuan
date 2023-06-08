//
//  StyleMaskNameToStyleMaskConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 11.01.23.
//

import Foundation

class StyleMaskNameToStyleMaskConverter {
    public static func getStyleMaskFromName(_ name: String) -> NSWindow.StyleMask {
        switch (name) {
        case "borderless":
            return .borderless
            
        case "titled":
            return .titled
            
        case "closable":
            return .closable
            
        case "miniaturizable":
            return .miniaturizable
            
        case "resizable":
            return .resizable
            
        case "unifiedTitleAndToolbar":
            return .unifiedTitleAndToolbar
            
        case "fullScreen":
            return .fullScreen
            
        case "fullSizeContentView":
            return .fullSizeContentView
            
        case "utilityWindow":
            return .utilityWindow
            
        case "docModalWindow":
            return .docModalWindow
            
        case "nonactivatingPanel":
            return .nonactivatingPanel
            
        case "hudWindow":
            return .hudWindow
            
        default:
            return .borderless
        }
    }
}
