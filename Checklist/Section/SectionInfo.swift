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
    init(title: String, items: [Any]) {
        self.title = title
        self.items = items
    }
    
    // MARK: - Stored Properties
    public var title: String?
    public var items: [Any] = []
    public var isExpanded: Bool = false
    public var addOn: Any?
    public var isEditInput: Bool = false
    
}
