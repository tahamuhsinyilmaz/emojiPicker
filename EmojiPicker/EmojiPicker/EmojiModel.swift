//
//  EmojiModel.swift
//  EmojiPicker
//
//  Created by onedio on 4.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
struct EmojiModel: Decodable{
    let status: Status?
    let data:EmojiModelData?
}

struct EmojiModelData: Decodable {
    let categories: [Category]?
    let emojis: [String: Emoji]?
}

struct Status: Decodable {
    
}

struct Category: Decodable {
    let id: Int?
    let name: String?
    var emojis: [String]?
}


struct Emoji: Decodable {
//               "a": 1,
//               "b": "sırıtan yüz",
//               "c": "1f600",
//               "d": [
//                   "gülen yüz",
//                   "gülme",
//                   "lol",
//                   "neşeli",
//                   "sırıtan yüz",
//                   "yüz"
//               ],
//               "e": "😀",
//               "f": 1,
//               "g": "https://dio-emoji.oned.io/1f600.png",
//               "h": [
//                   30,
//                   35
//               ]
    let a: Int?
    let b: String?
    let c: String?
    let d: [String]?
    let e: String?
    let f: Int?
    let g: String?
    let h: [Int]?
}
