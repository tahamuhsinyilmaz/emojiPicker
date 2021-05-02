//
//  EmojiCell.swift
//  EmojiPicker
//
//  Created by onedio on 4.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell{
    @IBOutlet weak var label: UILabel!
    
    var emoji: String!{
        didSet{
            updateUI()
        }
    }
    
    
    private func updateUI(){
        label.text = emoji
    }
}
