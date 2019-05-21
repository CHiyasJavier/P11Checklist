//
//  TextAreaView.swift
//  Earnest
//
//  Created by Arjin Reyes on 5/2/19.
//  Copyright © 2019 Novare Technologies, Inc. All rights reserved.
//

import SnapKit
import UIKit

public class TextAreaView: UIView {
    
    // MARK: - Delegate Declarations
    public weak var delegate: TextAreaViewDelegate?
    
    // MARK: - Subviews
    private lazy var characterCountlabel: UILabel = {
        let view: UILabel = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        view.font = UIFont.systemFont(
            ofSize: 12.0,
            weight: UIFont.Weight.bold
        )
        view.textColor = AppUI.Theme.componentAccessoryColor
        view.textAlignment = .right
        return view
    }()
    
    private lazy var doneBarButton: UIBarButtonItem = {
        let view: UIBarButtonItem = UIBarButtonItem()
        view.style = UIBarButtonItem.Style.plain
        view.title = "Done"
        view.target = self
        view.tintColor = AppUI.Theme.primaryColor
        view.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 16.0, weight: UIFont.Weight.bold
            )
            ], for: UIControl.State.normal)
        return view
    }()
    
    private lazy var errorIconImageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "error")
        return view
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let view: UILabel = UILabel()
        
        view.font = UIFont.systemFont(
            ofSize: 14.0
        )
        view.textColor = AppUI.Theme.errorColor
        view.textAlignment = NSTextAlignment.left
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var errorView: UIView = UIView()
    
    private lazy var fieldLabel: UILabel = {
        let view: UILabel = UILabel()
        view.text = self.label
        view.font = UIFont.systemFont(ofSize: 16.0)
        view.textColor = AppUI.Theme.textDefaultColor
        view.textAlignment = .left
        return view
    }()
    
    private lazy var helpTextLabel: UILabel = {
        let view: UILabel = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        view.attributedText = NSMutableAttributedString(
            string: self.helpText ?? "",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        view.font = UIFont.systemFont(
            ofSize: 14.0,
            weight: UIFont.Weight.bold
        )
        view.textColor = AppUI.Theme.buttonColor
        view.textAlignment = .left
        return view
    }()
    
    private lazy var horizontalLineView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = AppUI.Theme.bottomBorderColor
        return view
    }()
    
    private var textView: UITextView = {
        let view: UITextView = UITextView()
        view.font = UIFont.systemFont(ofSize: 16.0)
        view.autocapitalizationType = UITextAutocapitalizationType.none
        view.autocorrectionType = UITextAutocorrectionType.no
        return view
    }()
    
    // MARK: - Stored Properties
    private var label: String
    private var helpText: String?
    private var maxCharacterCount: Int
    
    // MARK: Initializer
    public init(label: String,
                helpText: String? = nil,
                maxCharacterCount: Int) {
        self.label = label
        self.maxCharacterCount = maxCharacterCount
        self.helpText = helpText
        
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clear
        
        self.errorView.subviews(forAutoLayout: [
            self.errorIconImageView, self.errorMessageLabel])
        
        self.subviews(forAutoLayout: [
            self.fieldLabel, self.characterCountlabel,
            self.textView, self.horizontalLineView,
            self.helpTextLabel, self.errorView])
        
        self.textView.delegate = self
        self.textView.textContainer.heightTracksTextView = true
        self.textView.isScrollEnabled = false
        
        self.characterCountlabel.text = "\(self.textView.text.count)/\(self.maxCharacterCount)"
        
        self.doneBarButton.action = #selector(self.finishEditing)
        self.setUpKeyboardToolbar()
        
        self.remakeConstraints()
    }
    
    private func setUpKeyboardToolbar() {
        let space: UIBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        
        let keyboardToolbar: UIToolbar = UIToolbar()
        
        keyboardToolbar.setItems(
            [space, self.doneBarButton],
            animated: false
        )
        keyboardToolbar.sizeToFit()
        self.textView.inputAccessoryView = keyboardToolbar
    }
    
    // swiftlint:disable function_body_length
    private func remakeConstraints() {
        self.fieldLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.height.equalTo(23.0)
            
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalToSuperview()
            }
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.characterCountlabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalToSuperview()
            }
            make.height.equalTo(self.fieldLabel.snp.height)
            make.width.equalTo(80.0)
            make.trailing.equalToSuperview()
        }
        
        self.textView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.fieldLabel.snp.bottom).offset(3.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.horizontalLineView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(1.0)
            make.top.equalTo(self.textView.snp.bottom)
            make.leading.equalTo(self.textView)
            make.trailing.equalTo(self.textView)
        }
        
        self.helpTextLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(17.0)
            make.top.equalTo(self.textView.snp.bottom).offset(11.0)
            make.leading.equalTo(self.textView)
            make.trailing.equalTo(self.textView)
        }
        
        //  Error View
        self.errorView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(20)
            make.top.equalTo(self.textView.snp.bottom).offset(11.0)
            make.leading.equalTo(self.textView)
            make.trailing.equalTo(self.textView)
        }
        
        self.errorIconImageView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(18)
            make.width.equalTo(18)
            make.top.equalToSuperview()
            make.leading.equalTo(self.errorView)
        }
        
        self.errorMessageLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.height.equalTo(18)
            make.top.equalToSuperview()
            make.leading.equalTo( self.errorIconImageView.snp.trailing).offset(6.0)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Public APIs
extension TextAreaView {
    
    public func setText(with text: String) {
        self.textView.text = text
    }
    
    public func setState(state: FieldState) {
        self.errorView.isHidden = true
        
        switch state {
        case .empty:
            self.fieldLabel.textColor = AppUI.Theme.textDefaultColor
            self.helpTextLabel.isHidden = true
            
        case .editing:
            self.fieldLabel.textColor = AppUI.Theme.secondaryColor
            self.helpTextLabel.isHidden = false
            
        case .editingError(let error):
            self.fieldLabel.textColor = AppUI.Theme.secondaryColor
            self.setUpErrorDisplay(with: error)
            
        case .editingSuccess:
            self.fieldLabel.textColor = AppUI.Theme.secondaryColor
            self.helpTextLabel.isHidden = false
            
        case .filledError(let error):
            self.fieldLabel.textColor =  AppUI.Theme.textDefaultColor
            self.setUpErrorDisplay(with: error)
            
        case .filledSuccess:
            self.fieldLabel.textColor = AppUI.Theme.textDefaultColor
            self.helpTextLabel.isHidden = true
        }
    }
    
    public func getTextArea() -> UITextView {
        return self.textView
    }
}
// MARK: Helper methods
extension TextAreaView {
    
    private func setUpErrorDisplay(with message: String?) {
        self.errorMessageLabel.text = message ?? nil
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        self.errorMessageLabel.attributedText = NSMutableAttributedString(
            string: message ?? "",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.errorView.isHidden = false
        self.helpTextLabel.isHidden = true
    }
}
// MARK: Target Action methods
extension TextAreaView {
    
    @objc func finishEditing() {
        self.textView.endEditing(true)
    }
}
// MARK: UITextViewDelegate methods
extension TextAreaView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        let textCount = self.textView.text.count
        self.characterCountlabel.text = "\(textCount)/\(maxCharacterCount)"
        
        guard let delegate = self.delegate else { return }
        delegate.textAreaViewDidChange(textView)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        if textView.text.count >= maxCharacterCount {
            return false
        }
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        guard let delegate = self.delegate else { return }
        delegate.textAreaViewDidEndEditing(textView)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard let delegate = self.delegate else { return }
        delegate.textAreaViewDidBeginEditing(textView)
    }
}
