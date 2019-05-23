//
//  ThoughtView.swift
//  Thought
//
//  Created by Novare Account on 04/04/2019.
//  Copyright © 2019 Alvin Joseph Valdez. All rights reserved.
//
import UIKit
import SnapKit

public final class ThoughtView: UIView {
    
    public weak var delegate: ThouthViewDelegate?
    
    // MARK: SubViews
    public let textLabel: UILabel = {
        let view: UILabel = UILabel()
        view.text = "Sample text"
        view.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.semibold)
        view.numberOfLines = 0
        return view
    }()
    
    private let closeButton: UIButton = {
        let view: UIButton = UIButton()
        view.setTitle("Close", for: UIControl.State.normal)
        view.setTitleColor(
            UIColor.black,
            for: UIControl.State.normal
        )
        view.titleLabel!.font = UIFont.systemFont(
            ofSize: 16.0,
            weight: UIFont.Weight.bold
        )
        return view
    }()
    
    private let closeImageButton: AJButton = {
        let view: AJButton = AJButton()
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 1.0
        view.backgroundColor = UIColor.white
        view.hitInsets = UIEdgeInsets(
            top: -40,
            left: -40,
            bottom: -40,
            right: -40
        )
        return view
    }()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.closeImageButton.layer.cornerRadius = self.closeImageButton.frame.width / 2
        
        self.subviews(forAutoLayout: [
            self.textLabel
        ])
        
        self.textLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().inset(10.0)
            make.bottom.equalToSuperview().inset(5.0)
            make.top.equalToSuperview().offset(5.0)
        }
    }
}

// MARK: - Public APIs
extension ThoughtView {
    public func fadeOut(duration: Int) {
        self.animate([
            .fadeOut(duration: TimeInterval(duration))
        ])
    }
    
    public func hide(after: Int) {
        self.animate([
            .hideAfter(duration: TimeInterval(after))
        ])
    }
    
    public func setMessage(_ text: String, color: UIColor = UIColor.black) {
        self.textLabel.text = text
        self.textLabel.textColor = color
    }
    
    public func setViewRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2
    }
    
    public func withShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = false
        
        self.layoutIfNeeded()
    }
    
    public func withClose() {
        self.subview(forAutoLayout: self.closeButton)
        
        self.closeButton.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(-15.0)
            make.trailing.equalToSuperview().inset(10.0)
        }
        
        self.closeButton.addTarget(
            self,
            action: #selector(ThoughtView.closeButtonTapped),
            for: UIControl.Event.touchUpInside
        )
        
        self.bringSubviewToFront(self.closeButton)
        
        self.layoutIfNeeded()
    }
    
    public func withClose(accesory: UIImage, size: CGFloat) {
        
        self.subview(forAutoLayout: self.closeImageButton)
        
        self.closeImageButton.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.height.equalTo(size)
            make.width.equalTo(size)
            make.top.equalToSuperview().offset(-10.0)
            make.trailing.equalToSuperview().inset(10.0)
        }
        
        self.closeImageButton.setImage(accesory, for: UIControl.State.normal)
        self.closeImageButton.addTarget(
            self,
            action: #selector(ThoughtView.closeButtonTapped),
            for: UIControl.Event.touchUpInside
        )
    }
}

// MARK: - Target Action Methods
extension ThoughtView {
    @objc func closeButtonTapped(_ sender: UIButton) {
        self.isHidden = true
        guard let delegate = self.delegate else { return }
        delegate.thoughtDidClose(view: self)
    }
}

// MARK: - Helper Methods
extension ThoughtView {
    private func animate(_ animations: [ThoughtAnimation]) {
        // Exit condition: once all animations have been performed, we can return
        guard !animations.isEmpty else {
            return
        }
        
        // Remove the first animation from the queue
        var animations = animations
        let animation = animations.removeFirst()
        
        // Perform the animation by calling its closure
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            // Recursively call the method, to perform each animation in sequence
            self.animate(animations)
        })
    }
}

public class AJButton: UIButton {
    // Create a property to store the hit insets:
    var hitInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        // Generate the new hit area by adding the hitInsets:
        let newRect = CGRect(
            x: 0 + hitInsets.left,
            y: 0 + hitInsets.top,
            width: self.frame.size.width - hitInsets.left - hitInsets.right,
            height: self.frame.size.height - hitInsets.top - hitInsets.bottom)
        
        // Check if the point is within the new hit area:
        return newRect.contains(point)
        
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let biggerButtonFrame = self.frame.insetBy(dx: -30, dy: -30)
        
        if biggerButtonFrame.contains(point) {
            return self
        }
        
        return super.hitTest(point, with: event)
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
}
