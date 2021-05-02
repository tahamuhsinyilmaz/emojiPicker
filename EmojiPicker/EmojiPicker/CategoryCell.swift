//
//  CategoryCell.swift
//  EmojiPicker
//
//  Created by onedio on 5.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit
class CategoryCell: UICollectionViewCell{
    var dataSource: [String]! = []{
        didSet{
            emojiCollectionView.reloadData()
        }
    }
    var completion: ((String?)->Void)!
    
    @IBOutlet weak var emojiCollectionView: UICollectionView!
}




extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        cell.emoji = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CommonLRUHandler.shared.setValue(key: dataSource[indexPath.row], value: dataSource[indexPath.row])
        let selectedEmoji = dataSource[indexPath.row]
        completion(selectedEmoji)
    }
}


