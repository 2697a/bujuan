//
//  PresentationOptionNameToPresentationOptionsConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 27.02.23.
//

import Foundation

class PresentationOptionNameToPresentationOptionsConverter {
    public static func getPresentationOptionsFromName(name: String) -> NSApplication.PresentationOptions? {
        switch (name) {
        case "autoHideDock":
            return .autoHideDock
            
        case "hideDock":
            return .hideDock
            
        case "autoHideMenuBar":
            return .autoHideMenuBar
            
        case "hideMenuBar":
            return .hideMenuBar
            
        case "disableAppleMenu":
            return .disableAppleMenu
            
        case "disableProcessSwitching":
            return .disableProcessSwitching
            
        case "disableForceQuit":
            return .disableForceQuit
            
        case "disableSessionTermination":
            return .disableSessionTermination
            
        case "disableHideApplication":
            return .disableHideApplication
            
        case "disableMenuBarTransparency":
            return .disableMenuBarTransparency
            
        case "fullScreen":
            return .fullScreen
            
        case "autoHideToolbar":
            return .autoHideToolbar
            
        case "disableCursorLocationAssistance":
            return .disableCursorLocationAssistance
                
        default:
            return nil
        }
    }
}
