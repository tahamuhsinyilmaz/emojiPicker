//
//  DoublyLinkedList.swift
//  EmojiPickerKit
//
//  Created by onedio on 6.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import Foundation
typealias DoublyLinkedListNode = DoublyLinkedList.Node


final class DoublyLinkedList: NSObject{
    
    private(set) var count: Int = 0
    private var head: Node?
    private var tail: Node?
    
    deinit {
        prepareForDealloc()
        head = nil
        tail = nil
        print("Deallocating linked list")
    }
    
    func prepareForDealloc() {
        var currentNode: Node?
        if var tail = tail {
            currentNode = tail
            repeat {
                tail = currentNode!
                currentNode = currentNode?.previous
                tail.previous = nil
                tail.next = nil
            } while (currentNode != nil) // nil is head
        } // end if var tail = tail
    }
    
    
    final class Node: NSObject{
        var payload: String
        var previous: Node?
        var next: Node?

        init(payload: String) {
            self.payload = payload
        }
        
    }
    
    func addHead(_ payload: String) -> Node {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }

        guard let head = head else {
            tail = node
            return node
        }

        head.previous = node

        node.previous = nil
        node.next = head

        return node
    }
    
    func moveToHead(_ node: Node?) {
        guard let node = node else {return}
        if node != head{
            let nodePrevieous = node.previous
            let nodeNext = node.next
            
            nodePrevieous?.next = nodeNext
            nodeNext?.previous = nodePrevieous
            
            self.head?.previous = node
            node.next = head
            self.head = node
        }
    }
    
    func getHead()->Node?{
        return self.head
    }
    
    func removeLast() -> Node? {
        guard let tail = self.tail else { return nil }

        let previous = tail.previous
        previous?.next = nil
        self.tail = previous

        if count == 1 {
            head = nil
        }

        count -= 1

        // 1
        return tail
    }
    
    func addLast(node: Node){
        
          node.previous = tail;
          node.next = nil;
        
        if (tail != nil){
            tail?.next = node;
        }
              
        
          tail = node;
        count += 1
    }
    
    func addNode(node: Node){
        if self.head == nil {
            self.head = node
            self.tail = node
        }else{
            self.addLast(node: node)
        }
    }
    
    func travers() -> [Node?]{
        guard let head = self.head else {return []}
        var temp: Node? = head
        var arr: [Node?] = []
        while temp != tail{
            arr.append(temp)
            temp = temp?.next
        }
        arr.append(tail)
        
        return arr
    }
    
    func populateList(from values: [String]){
        for i in values{
            addNode(node: Node(payload: i))
        }
    }
}
