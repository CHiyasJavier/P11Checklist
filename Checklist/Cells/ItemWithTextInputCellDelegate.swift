//
//  ItemWithTextInputCellDelegate.swift
//  Checklist
//
//  Created by Alvin Joseph Valdez on 21/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import Foundation

public protocol ItemWithTextInputCellDelegate: class {
    func saveTapped(on sectionIndex: Int)
    func cancelTapped(on sectionIndex: Int)
}
