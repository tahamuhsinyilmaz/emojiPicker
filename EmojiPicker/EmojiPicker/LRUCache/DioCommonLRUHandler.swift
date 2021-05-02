//
//  DioCommonLRUHandler.swift
//  EmojiPickerKit
//
//  Created by onedio on 6.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
class CommonLRUHandler{
    static var shared = CommonLRUHandler()
    private let cache = CacheLRU<String, String>(capacity: 30)
    private init(){}
    
    func setValue(key: String, value: String){
        cache.setValue(value)
    }
    
    func getAllValues()->[String]{
        var emojis: [String] = []
        emojis.append(contentsOf: cache.getAllValues())
        return emojis
    }
}
