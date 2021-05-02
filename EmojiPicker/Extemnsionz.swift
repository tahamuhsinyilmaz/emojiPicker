//
//  Extemnsionz.swift
//  EmojiPickerKit
//
//  Created by onedio on 7.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
//
//  TextFieldExtension.swift
//  Dio
//
//  Created by onedio on 27.12.2019.
//  Copyright © 2019 onedio. All rights reserved.
//

import UIKit
extension UITextField {
    //MARK: - TEXTFIELD LEFT & RIGHT PADDING AND IMAGE
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setLeftImage(imageName:String, color: UIColor) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 16))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 16, height: 16))
        paddingView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        imageView.tintColor = color
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightImage(imageName:String, color: UIColor) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 25))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 10))
        paddingView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setRightButton(imageName: String, tintColor: UIColor) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 25))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 17, height: self.frame.height))
        paddingView.addSubview(button)
        button.contentMode = .center
        button.tintColor = tintColor
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(self, action: #selector(textFieldFirstResponder), for: .touchUpInside)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @objc func textFieldFirstResponder(){
        self.becomeFirstResponder()
    }
    
    //MARK: - ADD BOTTOM BORDER
    func addBottomLine(color : CGColor = UIColor(named: "226Gray")!.cgColor ) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = color
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
    //MARK: - SPECIAL ANIMATION
    func shakeTextField(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

extension UITextField{
    func next(_ textField: UITextField){
        //self.resignFirstResponder()
        textField.becomeFirstResponder()
    }
}



extension UITextView{
    func setTopBar(){
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
    }
    
    func hideTopBar(){
        self.inputAccessoryView = nil
    }
    
    @objc func cancelNumberPad() {
        self.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        self.resignFirstResponder()
    }
}

extension UITextField{
    func setTopBar(){
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
    }
    
    func hideTopBar(){
        self.inputAccessoryView = nil
    }
    
    @objc func cancelNumberPad() {
        self.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        self.resignFirstResponder()
    }
}


