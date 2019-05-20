//
//  ChecklistItemHeaderViewDelegate.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 17/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import Foundation

public protocol ChecklistItemHeaderViewDelegate: class {
    func didToggleCheckbox(_ section: Int)
}
