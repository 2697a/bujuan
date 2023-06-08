//
//  VisualEffectSubviewProperties.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 22.10.22.
//

import Foundation

/// This class holds properties that can be applied to a VisualEffectSubview.
@available(macOS 10.14, *)
class VisualEffectSubviewProperties {
    public let frameSize: NSSize?
    public let frameOrigin: NSPoint?
    public let alphaValue: CGFloat?
    public let cornerRadius: CGFloat?
    public let maskedCorners: CACornerMask?
    public let material: NSVisualEffectView.Material?
    public let state: NSVisualEffectView.State?
    
    init(frameSize: NSSize?, frameOrigin: NSPoint?, alphaValue: CGFloat?, cornerRadius: CGFloat?, maskedCorners: CACornerMask?, material: NSVisualEffectView.Material?, state: NSVisualEffectView.State?) {
        self.frameSize = frameSize
        self.frameOrigin = frameOrigin
        self.alphaValue = alphaValue
        self.cornerRadius = cornerRadius
        self.maskedCorners = maskedCorners
        self.material = material
        self.state = state
    }
    
    /// Decodes the args and returns an instance of CACornerMask if the “cornerMask” argument is not nil. Returns nil otherwise.
    private static func getCornerMaskFromArgs(_ args: [String: Any]) -> CACornerMask? {
        let cornerMaskArgument = args["cornerMask"]
        
        if (cornerMaskArgument == nil) {
            return nil
        }
        
        let cornerMaskInteger = cornerMaskArgument as! UInt
        
        let completeCornerMask = [
            CACornerMask.layerMinXMaxYCorner,
            CACornerMask.layerMaxXMaxYCorner,
            CACornerMask.layerMaxXMinYCorner,
            CACornerMask.layerMinXMinYCorner
        ]
        let cornerMaskArray = [0, 1, 2, 3]
            .filter {((cornerMaskInteger >> $0) & 1) == 1}
            .map {completeCornerMask[$0]}
        return CACornerMask(cornerMaskArray)
    }
    
    /// Decodes the “material” argument and returns the associated NSVisualEffectView.Material if it is not nil. Returns nil otherwise.
    private static func getMaterialFromArgs(_ args: [String: Any]) -> NSVisualEffectView.Material? {
        let effectArgument = args["material"]
        
        if (effectArgument == nil) {
            return nil
        }
        
        let effectID = effectArgument as! NSNumber
        return MaterialIDToMaterialConverter.getMaterialFromMaterialID(effectID: effectID)
    }
    
    /// Decodes the “state” argument and returns the associated NSVisualEffectView.State if it is not nil. Returns nil otherwise.
    private static func getStateFromArgs(_ args: [String: Any]) -> NSVisualEffectView.State? {
        let stateArgument = args["state"]
        
        if (stateArgument == nil) {
            return nil
        }
        
        let stateString = stateArgument as! String
        let state = stateString == "active"   ? NSVisualEffectView.State.active :
                    stateString == "inactive" ? NSVisualEffectView.State.inactive :
                                                NSVisualEffectView.State.followsWindowActiveState
        return state;
    }
    
    /// Produces a VisualEffectSubviewProperties instance from an argument dictionary.
    public static func fromArgs(_ args: [String: Any]) -> VisualEffectSubviewProperties {
        let frameSize = args["frameWidth"] != nil && args["frameHeight"] != nil ? NSSize(
            width: args["frameWidth"] as! CGFloat,
            height: args["frameHeight"] as! CGFloat
        ) : nil
        let frameOrigin = args["frameX"] != nil && args["frameY"] != nil ? NSPoint(
            x: args["frameX"] as! CGFloat,
            y: args["frameY"] as! CGFloat
        ) : nil
        let alphaValue = args["alphaValue"] as? CGFloat
        let cornerRadius = args["cornerRadius"] as? CGFloat
        let maskedCorners = getCornerMaskFromArgs(args)
        let material = getMaterialFromArgs(args)
        let state = getStateFromArgs(args)
        
        return VisualEffectSubviewProperties(frameSize: frameSize, frameOrigin: frameOrigin, alphaValue: alphaValue, cornerRadius: cornerRadius, maskedCorners: maskedCorners, material: material, state: state)
    }
    
    /// Applies the stored properties to a provided VisualEffectSubview.
    public func applyToVisualEffectSubview(_ visualEffectSubview: VisualEffectSubview) {
        if (frameSize != nil) {
            visualEffectSubview.setFrameSize(frameSize!)
        }
        
        if (frameOrigin != nil) {
            visualEffectSubview.setFrameOrigin(frameOrigin!)
        }
        
        if (alphaValue != nil) {
            visualEffectSubview.alphaValue = alphaValue!
        }
        
        if (cornerRadius != nil) {
            if (cornerRadius! != 0) {
                visualEffectSubview.wantsLayer = true
                visualEffectSubview.layer?.cornerRadius = cornerRadius!
            } else {
                if (visualEffectSubview.wantsLayer) {
                    visualEffectSubview.layer?.cornerRadius = cornerRadius!
                }
            }
        }
        
        if (maskedCorners != nil) {
            visualEffectSubview.wantsLayer = true
            visualEffectSubview.layer?.maskedCorners = maskedCorners!
        }
        
        if (material != nil) {
            visualEffectSubview.material = material!
        }
        
        if (state != nil) {
            visualEffectSubview.state = state!
        }
    }
}
