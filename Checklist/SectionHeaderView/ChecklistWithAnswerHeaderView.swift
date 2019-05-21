//
// ChecklistitemWithAnswerHeaderView.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 17/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import UIKit
import SnapKit

class ChecklistWithAnswerHeaderView: UITableViewHeaderFooterView {

    // MARK: Delegates
    public weak var delegate: ChecklistWithAnswerHeaderViewDelegate?
    
    // MARK: Subviews
    private let checkImage: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "check-green")
        view.contentMode = UIView.ContentMode.scaleAspectFit
        return view
    }()
    
    private let itemLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.adjustsFontSizeToFitWidth = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let itemInputLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.textColor = UIColor(red: 0.51, green: 0.60, blue :0.63, alpha: 1.0)
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.adjustsFontSizeToFitWidth = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let editButton: UIButton = {
        let view: UIButton = UIButton(type: UIButton.ButtonType.custom)
        view.setTitle("Edit", for: UIControl.State.normal)
        view.setTitleColor(UIColor(red: 0.51, green: 0.60, blue: 0.63, alpha: 1.0), for: UIControl.State.normal)
        view.addTarget(self, action: #selector(ChecklistWithAnswerHeaderView.didTap), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    public let maskingView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        return view
    }()

    // MARK: Stored Properties
    private var section: Int = 0
    
    // MARK: Initializers
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.subviews(forAutoLayout: [self.checkImage, self.itemLabel, self.itemInputLabel, self.editButton])
        self.checkImage.snp.remakeConstraints { (make: ConstraintMaker) in
            make.top.equalToSuperview().offset(10.0)
            make.leading.equalToSuperview().offset(20.0)
            make.height.equalTo(30.0)
        }
        
        self.itemLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.leading.equalTo(self.checkImage.snp.trailing).offset(10.0)
            make.centerY.equalTo(self.checkImage.snp.centerY)
        }
        
        self.itemInputLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.leading.equalTo(self.checkImage.snp.trailing).offset(10.0)
            make.top.equalTo(self.itemLabel.snp.bottom).offset(10.0)
//            make.bottom.equalToSuperview().inset(10.0)
        }
        
        self.editButton.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.leading.equalTo(self.itemInputLabel.snp.trailing).offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.width.equalTo(60.0)
            make.centerY.equalToSuperview()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Target Action Methods
extension ChecklistWithAnswerHeaderView {
    
    @objc public func didTap(_ sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.didTap(self.section)
    }
}


// MARK: - Public APIs
extension ChecklistWithAnswerHeaderView {
    public static var identifier: String = "ChecklistWithAnswerHeaderView"
    
    public func setTitle(_ title: String) {
        self.itemLabel.text = title
    }
    
    public func setSubTitle(_ subTitle: String) {
        self.itemInputLabel.text = subTitle
    }
    
    public func setSection(_ section: Int) {
        self.section = section
    }
    
    public func hasMasked() {
        self.subview(forAutoLayout: self.maskingView)
        
        self.maskingView.snp.remakeConstraints { (make: ConstraintMaker) in
            make.edges.equalToSuperview()
        }
    }
    
    public func removeMasking() {
        self.maskingView.removeFromSuperview()
    }
}


