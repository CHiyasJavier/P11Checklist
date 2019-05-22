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
    
    // MARK: - Delegate Declaration
    private weak var delegate: ItemWithTextInputCellDelegate?
    
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
    
    public let saveButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("Save", for: UIControl.State.normal)
        view.setTitleColor(
            UIColor.blue,
            for: UIControl.State.normal
        )
        view.titleLabel?.font = UIFont.systemFont(
            ofSize: 12.0,
            weight: UIFont.Weight.semibold
        )
        view.isHidden = true
        return view
    }()
    
    public let cancelButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("Cancel", for: UIControl.State.normal)
        view.setTitleColor(
            AppUI.Theme.buttonColor,
            for: UIControl.State.normal
        )
        view.titleLabel?.font = UIFont.systemFont(
            ofSize: 12.0,
            weight: UIFont.Weight.semibold
        )
        view.isHidden = true
        return view
    }()
    
    public let toolTipButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("Why are we asking this?", for: UIControl.State.normal)
        view.setTitleColor(
            AppUI.Theme.buttonColor,
            for: UIControl.State.normal
        )
        view.titleLabel?.font = UIFont.systemFont(
            ofSize: 12.0,
            weight: UIFont.Weight.semibold
        )
        view.isHidden = false
        return view
    }()
    
    public let toolTip: ThoughtView = {
        let view: ThoughtView = ThoughtView()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        return view
    }()
    
    // MARK: Initializers
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.subviews(forAutoLayout: [
            self.supportingAnswerView,self.cancelButton,
             self.saveButton, self.toolTipButton,
            self.toolTip
        ])
        
        self.supportingAnswerView.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            
            make.height.equalTo(70.0)
        }
        
        self.saveButton.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.trailing.equalToSuperview()
            make.height.equalTo(20.0)
            make.width.equalTo(80.0)
            make.top.equalTo(self.supportingAnswerView.snp.bottom).offset(5.0)
        }
        
        self.cancelButton.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.saveButton)
            make.height.equalTo(20.0)
            make.width.equalTo(80.0)
            make.trailing.equalTo(self.saveButton.snp.leading).inset(20.0)
        }
        
        self.toolTipButton.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) in
            make.trailing.equalToSuperview().inset(20.0)
            make.height.equalTo(20.0)
            make.top.equalTo(self.supportingAnswerView.snp.bottom).offset(5.0)
        }
        
        self.toolTip.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.supportingAnswerView.snp.bottom).offset(10.0)
            self.toolTipHeight = make.height.equalTo(60.0).constraint
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
        }
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(ItemWithTextInputCell.didRecognizeTapGesture)
        )
        
        self.saveButton.addTarget(
            self,
            action: #selector(ItemWithTextInputCell.saveButtonTapped),
            for: UIControl.Event.touchUpInside
        )
        
        self.toolTipButton.addTarget(
            self,
            action: #selector(ItemWithTextInputCell.toolTipButtonTapped),
            for: UIControl.Event.touchUpInside
        )
        
        self.cancelButton.addTarget(self, action: #selector(ItemWithTextInputCell.cancelButtonTapped), for: UIControl.Event.touchUpInside)
        
        self.supportingAnswerView.getTextArea().addGestureRecognizer(tapGesture)
        self.supportingAnswerView.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.toolTip.withShadow()
        
        let message: String = "Au Revoir, Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne  Chienne "
        
        self.toolTip.setMessage(message, color: UIColor.black)
        
        let height: CGFloat = message.height(
            withConstrainedWidth: 300.0,
            font: UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.semibold)
        )
        
        self.toolTipHeight.update(offset: height + 20)
        self.toolTip.setViewRadius(radius: 9.0)
        self.toolTip.withClose(accesory: #imageLiteral(resourceName: "close-icon"), size: 20.0)
        self.layoutIfNeeded()
    }
    
    // MARK: - Stored Properties
    private var model: SectionInfo!
    private var sectionIndex: Int!
    private var toolTipHeight: Constraint!
    
}

// MARK: - Public APIs
extension ItemWithTextInputCell {
    public static var identifier: String = "ItemWithTextInputCell"
    
    public func configure(with model: SectionInfo, delegate: ItemWithTextInputCellDelegate, sectionIndex: Int) {
        self.model = model
        self.delegate = delegate
        self.sectionIndex = sectionIndex
        
        self.supportingAnswerView.getTextArea().text = self.model.supportingAnswer
        
        switch self.model.supportingAnswer.isEmpty {
        case true:
             self.saveButton.isHidden = true
             self.cancelButton.isHidden = true
             self.toolTipButton.isHidden = false
        case false:
            self.saveButton.isHidden = false
            self.cancelButton.isHidden = false
            self.toolTipButton.isHidden = true
        }
    }
}

extension ItemWithTextInputCell {
    
    @objc func didRecognizeTapGesture( _ gesture: UITapGestureRecognizer) {
        self.supportingAnswerView.getTextArea().becomeFirstResponder()
        self.cancelButton.isHidden = false
        self.toolTipButton.isHidden = true
    }
    
    @objc func saveButtonTapped( _ sender: UIButton) {
        
        guard let delegate = self.delegate else { return }
        
        if let text = self.supportingAnswerView.getTextArea().text {
            let trimmedText = text.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines
            )
            
            switch !trimmedText.isEmpty {
            case true:
                self.model.supportingAnswer = trimmedText
                self.model.isEditInput = true
                delegate.saveTapped(on: self.sectionIndex)
            case false:
                break
            }
            
        }
    }
    
    @objc func toolTipButtonTapped( _ sender: UIButton) {
        self.toolTip.isHidden = false
    }
    
    @objc func cancelButtonTapped( _ sender: UIButton) {
        guard let delegate = self.delegate else { return }
        
        if let index = self.sectionIndex {            
            if let text = self.supportingAnswerView.getTextArea().text {
                let trimmedText = text.trimmingCharacters(
                    in: CharacterSet.whitespacesAndNewlines
                )
                
                switch !trimmedText.isEmpty && !self.model.supportingAnswer.isEmpty {
                case true:
                    self.model.supportingAnswer = trimmedText
                    self.model.isEditInput = true
                    delegate.cancelTapped(on: index)
                case false:
                    delegate.cancelTapped(on: index)
                }
            }
        }
    }
}

// MARK: - TextAreaViewDelegate Methods
extension ItemWithTextInputCell: TextAreaViewDelegate {
    
    public func textAreaViewDidChange(_ textView: UITextView) {
        
        if let text = textView.text {
            let trimmedText = text.trimmingCharacters(
                in: CharacterSet.whitespacesAndNewlines
            )
            
            switch !trimmedText.isEmpty {
            case true:
                self.saveButton.isHidden = false
                self.cancelButton.isHidden = false
                self.toolTipButton.isHidden = true
            case false:
                self.saveButton.isHidden = true
                self.cancelButton.isHidden = true
                self.toolTipButton.isHidden = false
            }
        }
        
    }
    
    public func textAreaViewShouldReturn(_ textView: UITextView) -> Bool {
        self.saveButton.isHidden = true
        return true
    }
}
