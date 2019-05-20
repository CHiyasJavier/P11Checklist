//
//  Item.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 20/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import Foundation

public class Item: NSObject {
    
    // MARK: - Initializers
    public init(title: String) {
        self.title = title
    }
    
    // MARK: - Stored Properties
    public var title: String
}
