//
//  EmojiPickerHandler.swift
//  EmojiPickerKit
//
//  Created by onedio on 7.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit
final class EmojiPickerHandler{
    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VCEmojiPicker") as! VCEmojiPicker
    private init(){}
    static var shared = EmojiPickerHandler()
    
    
    func showEmojiPicker(containerVC: UIViewController, completion: @escaping (String?)->()){
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        vc.completion = completion
        containerVC.present(vc, animated: true) {
            UIView.animate(withDuration: 0.3) {
                self.vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            }
        }
    }
    
    func hideEmojiPicker(){
        self.vc.view.backgroundColor = .clear
        vc.dismiss(animated: true, completion: nil)
    }
    
}
