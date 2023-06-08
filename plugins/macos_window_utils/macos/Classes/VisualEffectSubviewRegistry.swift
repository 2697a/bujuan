//
//  VisualEffectSubviewHandler.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 22.10.22.
//

import Foundation

/// This class is used to register and retrieve VisualEffectSubviews.
class VisualEffectSubviewRegistry {
    /// Maps subview IDs to subview instances.
    private var idToSubview: [UInt: VisualEffectSubview] = [:]
    
    /// The ID value of the subview that is going to be registered next.
    private var nextSubviewId: UInt = 0
    
    /// Returns a new, yet unused ID value.
    private func getNewId() -> UInt {
        nextSubviewId += 1
        return nextSubviewId - 1
    }
    
    /// Registers a subview and returns its ID.
    public func registerSubview(_ subview: VisualEffectSubview) -> UInt {
        let subviewId = getNewId()
        idToSubview[subviewId] = subview
        return subviewId
    }
    
    /// Deregisters a subview.
    public func deregisterSubview(_ id: UInt) {
        idToSubview.removeValue(forKey: id)
    }
    
    /// Returns the subview with the given ID. Returns nil if the function is unused.
    public func getSubviewFromId(_ subviewId: UInt) -> VisualEffectSubview? {
        return idToSubview[subviewId]
    }
}
