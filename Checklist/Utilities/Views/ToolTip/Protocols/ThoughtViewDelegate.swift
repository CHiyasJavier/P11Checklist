//
//  ThoughtViewDelegate.swift
//  Thought
//
//  Created by Alvin Joseph Valdez on 26/04/2019.
//  Copyright © 2019 Alvin Joseph Valdez. All rights reserved.
//
import Foundation

public protocol ThouthViewDelegate: class {
    func thoughtDidClose(view: ThoughtView)
}

extension ThouthViewDelegate {
    public func thoughtDidClose(view: ThoughtView){}
}
