//
//  ItemWithTextInputCell.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 20/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import UIKit
import SnapKit

public class ItemWithTextInputCell: UITableViewCell {
    
    // MARK: - Subviews
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initializers
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.red
    }
    
}

// MARK: - Public APIs
extension ItemWithTextInputCell {
    public static var identifier: String = "ItemWithTextInputCell"
    
}
