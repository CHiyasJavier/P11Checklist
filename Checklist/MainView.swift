//
//  MainView.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 17/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {

    public let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = true
        view.allowsSelection = false
        view.estimatedRowHeight = 100.0
        view.rowHeight = UITableView.automaticDimension
        view.separatorColor = UIColor.clear
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.subviews(forAutoLayout: [self.tableView])
        
        self.tableView.snp.remakeConstraints { (make: ConstraintMaker) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
