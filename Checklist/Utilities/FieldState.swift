//
//  FieldState.swift
//  p11-textfield
//
//  Created by Arjin Reyes on 4/2/19.
//  Copyright © 2019 Arjin Reyes. All rights reserved.
//

import Foundation

public enum FieldState {
    case empty,
    editing,
    editingError(error: String?),
    editingSuccess,
    filledError(error: String?),
    filledSuccess
}
