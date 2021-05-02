//
//  CacheLRU.swift
//  EmojiPickerKit
//
//  Created by onedio on 6.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation

final class CacheLRU<Key: Hashable, Value> {
    
    let userDefaultsKey = "FrequentlyEmojis"
    private let capacity: Int
    private var list = DoublyLinkedList()
    private var nodesDict = [DoublyLinkedListNode?]()

    init(capacity: Int) {
        self.capacity = max(0, capacity)
        initList()
    }
    
    private func initList(){
        let values = getAllValues()
        list.populateList(from: values)
        
        nodesDict.append(contentsOf: list.travers())
        
    }

    func setValue(_ value: String){
        let filteredNode = nodesDict.filter {$0?.payload == value}
        if list.count > capacity {
            let deletedNode = list.removeLast()
            var deletedIndex: Int?
            for i in nodesDict.indices{
                if nodesDict[i] == deletedNode{
                    deletedIndex = i
                }
            }
            guard let safeDeletedIndex = deletedIndex else {return}
            nodesDict.remove(at: safeDeletedIndex)

        }
        if filteredNode.isEmpty{
            let node = list.addHead(value)
            nodesDict.append(node)
        }else{
            list.moveToHead(filteredNode.first!)
        }



        let userDefaults = UserDefaults.standard
        let encodedData: [String] = list.travers().map {($0?.payload ?? "") as String}
        userDefaults.set(encodedData, forKey: userDefaultsKey)
    }
    
    func getAllValues()->[String]{
        guard let nodeValues = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] else{
            return []
        }
        
        return nodeValues
        
    }
}
