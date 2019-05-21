//
//  SectionInfo.swift
//  Earnest
//
//  Created by Julius Abarra on 07/05/2019.
//  Copyright © 2019 Novare Technologies, Inc. All rights reserved.
//

import Foundation

public class SectionInfo: NSObject {
    
    // MARK: - Initializers
    init(title: String, items: [Any], withInput supportingAnswer: String = "", isEditInput: Bool = false) {
        self.title = title
        self.items = items
        self.supportingAnswer = supportingAnswer
        self.isEditInput = isEditInput
    }
    
    // MARK: - Stored Properties
    public var title: String?
    public var items: [Any] = []
    public var isExpanded: Bool = false
    public var addOn: Any?
    public var isEditInput: Bool
    public var supportingAnswer: String
}
