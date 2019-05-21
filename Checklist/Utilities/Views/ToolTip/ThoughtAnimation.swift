//
//  ThoughtAnimation.swift
//  Thought
//
//  Created by Novare Account on 04/04/2019.
//  Copyright © 2019 Alvin Joseph Valdez. All rights reserved.
//
import UIKit

public struct ThoughtAnimation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

public extension ThoughtAnimation {
    static func fadeIn(duration: TimeInterval = 0.3) -> ThoughtAnimation {
        return ThoughtAnimation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    static func fadeOut(duration: TimeInterval = 0.3) -> ThoughtAnimation {
        return ThoughtAnimation(duration: duration, closure: { $0.alpha = 0 })
    }
    
    static func hideAfter(duration: TimeInterval = 0.3) -> ThoughtAnimation {
        return ThoughtAnimation(duration: duration) { (view: UIView) in
            Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
                view.isHidden = true
            }
        }
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> ThoughtAnimation {
        return ThoughtAnimation(duration: duration, closure: { $0.bounds.size = size })
    }
}
