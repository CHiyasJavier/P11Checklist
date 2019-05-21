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
    public let supportingAnswerView: TextAreaView = {
        let view: TextAreaView = TextAreaView(
            label: "Where did you get the fund?",
            maxCharacterCount: 500
        )
        let state: FieldState = FieldState.empty
        view.setState(state: state)
        return view
    }()
    
    // MARK: Initializers
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.subviews(forAutoLayout: [self.supportingAnswerView])
        
        self.supportingAnswerView.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(ItemWithTextInputCell.didRecognizeTapGesture)
        )
        
        self.supportingAnswerView.getTextArea().addGestureRecognizer(tapGesture)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var model: SectionInfo!
    
}

// MARK: - Public APIs
extension ItemWithTextInputCell {
    public static var identifier: String = "ItemWithTextInputCell"
    
    public func configure(with model: SectionInfo) {
        self.model = model
    }
}

extension ItemWithTextInputCell {
    
    @objc func didRecognizeTapGesture(_ gesture: UITapGestureRecognizer) {
        print("boom")
        self.supportingAnswerView.getTextArea().becomeFirstResponder()
    }
    
}
