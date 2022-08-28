//
//  DesignableTextField.swift
//  OpenWeatherApp
//
//  Created by valters.steinblums on 26/08/2022.
//

import UIKit
@IBDesignable


class DesignableTextField: UITextField {

    @IBInspectable var leftImage : UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth:  CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }



    func updateView() {
        if let image = leftImage {
            leftViewMode = .always

            // assigning image
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 20

            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width = width + 5
            }

            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
            view.addSubview(imageView)
            leftView = view

        } else {
            // image is nill
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "" , attributes: [NSAttributedString.Key.foregroundColor: tintColor!])
        
    }
}


