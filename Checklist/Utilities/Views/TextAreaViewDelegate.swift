//
//  TextAreaViewDelegate.swift
//  Earnest
//
//  Created by Arjin Reyes on 5/6/19.
//  Copyright © 2019 Novare Technologies, Inc. All rights reserved.
//

import UIKit

public protocol TextAreaViewDelegate: class {
    
    func textAreaViewDidBeginEditing(_ textView: UITextView)
    func textAreaViewDidChange(_ textView: UITextView)
    func textAreaViewDidEndEditing(_ textView: UITextView)
    func textAreaViewShouldReturn(_ textView: UITextView) -> Bool
    func textAreaView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
}

extension TextAreaViewDelegate {
    
    public func textAreaViewDidBeginEditing(_ textView: UITextView) {}
    public func textAreaViewDidChange(_ textView: UITextView) {}
    public func textAreaViewDidEndEditing(_ textView: UITextView) {}
    public func textAreaViewShouldReturn(_ textView: UITextView) -> Bool {
        return true
    }
    public func textAreaView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}
