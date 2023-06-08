//
//  EffectIDToMaterialConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 21.10.22.
//

import Foundation

public class MaterialIDToMaterialConverter {
    @available(macOS 10.14, *)
    public static func getMaterialFromMaterialID(effectID: NSNumber) -> NSVisualEffectView.Material {
        switch (effectID) {
        case 0: // titlebar
            return NSVisualEffectView.Material.titlebar
                    
        case 1: // selection
            return NSVisualEffectView.Material.selection
            
        case 2: // menu
            return NSVisualEffectView.Material.menu
            
        case 3: // popover
            return NSVisualEffectView.Material.popover
            
        case 4: // sidebar
            return NSVisualEffectView.Material.sidebar
            
        case 5: // headerView
            return NSVisualEffectView.Material.headerView
            
        case 6: // sheet
            return NSVisualEffectView.Material.sheet
            
        case 7: // windowBackground
            return NSVisualEffectView.Material.windowBackground
            
        case 8: // hudWindow
            return NSVisualEffectView.Material.hudWindow
            
        case 9: // fullScreenUI
            return NSVisualEffectView.Material.fullScreenUI
            
        case 10: // toolTip
            return NSVisualEffectView.Material.toolTip
            
        case 11: // contentBackground
            return NSVisualEffectView.Material.contentBackground
            
        case 12: // underWindowBackground
            return NSVisualEffectView.Material.underWindowBackground
            
        case 13: // underPageBackground
            return NSVisualEffectView.Material.underPageBackground
            
        default:
            return NSVisualEffectView.Material.windowBackground
        }
    }
}
