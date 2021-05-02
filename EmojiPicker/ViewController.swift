//
//  ViewController.swift
//  EmojiPickerKit
//
//  Created by onedio on 7.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func showPickerButton(_ sender: UIButton){
        EmojiPickerHandler.shared.showEmojiPicker(containerVC: self) { (emoji) in
            guard let emoji = emoji else {return}
            print(emoji)
        }
    }

}
