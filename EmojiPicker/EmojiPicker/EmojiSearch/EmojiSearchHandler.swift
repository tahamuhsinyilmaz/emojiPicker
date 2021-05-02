//
//  EmojiSearchHandler.swift
//  EmojiPickerKit
//
//  Created by onedio on 11.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
class EmojiSearchHandler{
    
    var emojiModel: [Emoji]!
    
    init(emojiModel: [Emoji]) {
        self.emojiModel = emojiModel
    }
    
    
    func searchEmoji(searchtext: String) -> [String]{
        var arr: [String]! = []
        for i in emojiModel{
            let _ = i.d?.map({
                if $0.contains(searchtext){
                arr.append(i.e ?? "")
                }
            })
        }
        return arr
    }
}
