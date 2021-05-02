//
//  SearchTextField.swift
//  EmojiPickerKit
//
//  Created by onedio on 7.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
//
//  SearchTextField.swift
//  Dio
//
//  Created by onedio on 13.04.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit

class SearchTextField: UITextField{
    private var buttonAction: ()->() = {}
    private let deleteButton = UIButton(type: .custom)
    private var paddingView: UIView!
    func setDeleteButton(buttonAction: @escaping ()->()){
        self.buttonAction = buttonAction
        self.setNeedsLayout()
        self.layoutIfNeeded()
        paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: self.frame.size.height))
        deleteButton.setImage(UIImage(named: "linkPreviewClose"), for: .normal)
        deleteButton.backgroundColor = .clear
        deleteButton.tintColor = tintColor
        deleteButton.frame = CGRect(x: CGFloat(0), y: 0, width: CGFloat(27), height: CGFloat(21))
        deleteButton.addTarget(self, action: #selector(showHidePass), for: .touchUpInside)
        paddingView.addSubview(deleteButton)
        NSLayoutConstraint(item: deleteButton as Any, attribute: .leading, relatedBy: .equal, toItem: paddingView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: deleteButton as Any, attribute: .trailing, relatedBy: .equal, toItem: paddingView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: deleteButton as Any, attribute: .top, relatedBy: .equal, toItem: paddingView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: deleteButton as Any, attribute: .bottom, relatedBy: .equal, toItem: paddingView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = true
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setSearchImage(){
        let leftView = UIView()
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "searchAlt"), for: .normal)
        leftView.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            leftButton.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            leftButton.topAnchor.constraint(equalTo: leftView.topAnchor),
            leftButton.bottomAnchor.constraint(equalTo: leftView.bottomAnchor)
        ])
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 30 , height: bounds.height)
    }
    
    func hideDeleteButton(){
        self.rightView = nil
    }
    
    
    @objc func showHidePass(){
        buttonAction()
    }
    
    func debounce(interval: Int, queue: DispatchQueue, action: @escaping (() -> Void)) {
        let lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(interval)
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action()
            }
        }
    }
    
}
