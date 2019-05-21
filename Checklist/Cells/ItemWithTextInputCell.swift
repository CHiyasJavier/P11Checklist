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
        view.setTitle("SAVE", for: UIControl.State.normal)
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
    
    // MARK: Initializers
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.subviews(forAutoLayout: [
            self.supportingAnswerView, self.saveButton
        ])
        
        self.supportingAnswerView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            make.bottom.equalTo(self.saveButton.snp.top).inset(5.0)
        }
        
        self.saveButton.snp.remakeConstraints { (make: ConstraintMaker) in
            make.trailing.equalToSuperview().inset(20.0)
            make.width.equalTo(35.0)
            make.height.equalTo(20.0)
            make.bottom.equalToSuperview()
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
        
        self.supportingAnswerView.getTextArea().addGestureRecognizer(tapGesture)
        self.supportingAnswerView.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var model: SectionInfo!
    private var sectionIndex: Int!
    
}

// MARK: - Public APIs
extension ItemWithTextInputCell {
    public static var identifier: String = "ItemWithTextInputCell"
    
    public func configure(with model: SectionInfo, delegate: ItemWithTextInputCellDelegate, sectionIndex: Int) {
        self.model = model
        self.delegate = delegate
        self.sectionIndex = sectionIndex
        
        self.supportingAnswerView.getTextArea().text = self.model.supportingAnswer
    }
}

extension ItemWithTextInputCell {
    
    @objc func didRecognizeTapGesture( _ gesture: UITapGestureRecognizer) {
        self.supportingAnswerView.getTextArea().becomeFirstResponder()
    }
    
    @objc func saveButtonTapped( _ sender: UIButton) {
        print("booom ba yah")
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
}

// MARK: - TextAreaViewDelegate Methods
extension ItemWithTextInputCell: TextAreaViewDelegate {
    
    public func textAreaViewDidChange(_ textView: UITextView) {
        self.saveButton.isHidden = false
    }
    
    public func textAreaViewShouldReturn(_ textView: UITextView) -> Bool {
        self.saveButton.isHidden = true
        return true
    }
}
