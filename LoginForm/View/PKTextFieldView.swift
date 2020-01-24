//
//  PKTextFieldView.swift
//  LoginForm
//
//  Created by Prashant Rai on 14/11/19.
//  Copyright © 2019 Prokarma. All rights reserved.
//

import UIKit

class PKTextFieldView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


@IBDesignable
class UITextFieldX: UITextField {
    
    @IBInspectable var borderWidth: CGFloat = 0.8 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var boarderColor: UIColor = UIColor.darkGray {
        didSet {
            self.layer.borderColor = boarderColor.cgColor
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 8)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    private var _isRightViewVisible: Bool = true
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    func updateView() {
        setLeftImage()
        setRightImage()
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: tintColor])
    }
    
    func setLeftImage() {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = tintColor
            
            var width = image.size.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }
        
        leftView = view
    }
    
    func setRightImage() {
        rightViewMode = UITextField.ViewMode.always
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = image.size.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        
        rightView = view
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var textFont: Int  = 0 {
        didSet {
            // self.font = FontType.getFont(rawValue: textFont)
        }
    }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    func updateBottomBoarderFrame() {
        
        self.layer.sublayers?.forEach({ (tempLayer) in
            if tempLayer.frame.height == 1 {
                var layerFrame = tempLayer.frame
                layerFrame.size.width = self.frame.width
                tempLayer.masksToBounds = true
                tempLayer.frame = layerFrame
            }
        })
    }
}
