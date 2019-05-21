//
//  ChecklistItemHeaderView.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 17/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import UIKit
import SnapKit

public class ChecklistItemHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Delegates
    public weak var delegate: ChecklistItemHeaderViewDelegate?

    // MARK: - Subviews
    public let checkboxButton: UIButton = {
        let view: UIButton = UIButton(type: UIButton.ButtonType.custom)
        view.setImage(#imageLiteral(resourceName: "uncheck-checkBox"), for: UIControl.State.normal)
        view.setImage(#imageLiteral(resourceName: "checked_checkBox"), for: UIControl.State.selected)
        view.addTarget(self, action: #selector(ChecklistItemHeaderView.toggleCheckbox), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    private let itemLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.adjustsFontSizeToFitWidth = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    public let maskingView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        return view
    }()
    
    // MARK: Stored Properties
    private var section: Int = 0

    // MARK: Initializers
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.subviews(forAutoLayout: [self.checkboxButton, self.itemLabel])
        self.checkboxButton.isSelected = false
        self.checkboxButton.snp.remakeConstraints { (make: ConstraintMaker) in
            make.leading.equalToSuperview().offset(20.0)
            make.height.equalTo(30.0)
            make.centerY.equalToSuperview()
        }
        
        self.itemLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.leading.equalTo(self.checkboxButton.snp.trailing).offset(20.0)
            make.centerY.equalToSuperview()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Target Action Methods
extension ChecklistItemHeaderView {

    @objc public func toggleCheckbox(_sender: UIButton) {
        self.checkboxButton.isSelected = !self.checkboxButton.isSelected
        guard let delegate = self.delegate else { return }
        delegate.didToggleCheckbox(self.section)
    }
}

// MARK: - Public APIs
extension ChecklistItemHeaderView {
    public static var identifier: String = "ChecklistItemHeaderView"
    
    public func setTitle(_ title: String) {
        self.itemLabel.text = title
    }
    
    public func setSection(_ section: Int) {
        self.section = section
    }
    
    public func addMasking() {
        self.subview(forAutoLayout: self.maskingView)
        
        self.maskingView.snp.remakeConstraints { (make: ConstraintMaker) in
            make.edges.equalToSuperview()
        }
    }
    
    public func removeMasking() {
        self.maskingView.removeFromSuperview()
    }
}


