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
    init(section: Int, title: String, items: [Any]) {
        self.section = section
        self.title = title
        self.items = items
    }
    
    // MARK: - Stored Properties
    public var section: Int
    public var title: String?
    public var items: [Any] = []
    public var isExpanded: Bool = false
    public var addOn: Any?
    
}

// MARK: - Public APIs
extension SectionInfo {
    
    public func indexPaths() -> [IndexPath] {
        var indexPaths: [IndexPath] = [IndexPath]()
        let rowCount = self.items.count
        
        for row in 0..<rowCount {
            let indexPath: IndexPath = IndexPath(row: row, section: self.section)
            indexPaths.append(indexPath)
        }
        
        return indexPaths
    }
    
}
