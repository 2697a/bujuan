//
//  LevelNameToLevelConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 11.01.23.
//

import Foundation

class LevelNameToLevelConverter {
    public static func getLevelFromName(_ name: String) -> NSWindow.Level {
        switch (name) {
        case "floating":
            return .floating
        
        case "mainMenu":
            return .mainMenu
            
        case "modalPanel":
            return .modalPanel
            
        case "normal":
            return .normal
            
        case "popUpMenu":
            return .popUpMenu
            
        case "screenSaver":
            return .screenSaver
            
        case "statusBar":
            return .statusBar
            
        case "submenu":
            return .submenu
            
        case "tornOffMenu":
            return .tornOffMenu
            
        default:
            return .normal
        }
    }
}
