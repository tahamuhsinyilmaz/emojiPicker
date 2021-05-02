//
//  ViewController.swift
//  EmojiPicker
//
//  Created by onedio on 4.08.2020.
//  Copyright © 2020 onedio. All rights reserved.
//

import UIKit

class VCEmojiPicker: UIViewController {
    let searchedEmojis: [String] = CommonLRUHandler.shared.getAllValues()
    var categories: [Category]!
    var fullCategories: [Category]!
    var fullEmojis: [String: Emoji]! = [:]{
        didSet{
            setHandler()
        }
    }
    var categoryDataSource: [String: Emoji]! = [:]{
        didSet{
            initCollection()
        }
    }
    var completion: ((String?)->Void)!
    var searchHandler: EmojiSearchHandler!
    
    @IBOutlet weak var sliderViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextfield()
        fetchEmojiCategories()
        setGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func categoryButtonActions(_ sender: UIButton){
        categoryCollectionView.scrollToItem(at: IndexPath(row: sender.tag, section: 0), at: .right, animated: true)
    }
    
    @IBAction func searchTextFieldAction(_ sender: Any) {
        if searchTextField.text != ""{
            if searchTextField.text!.count > 2{
                searchTextField.debounce(interval: 300, queue: DispatchQueue.main) {
                    self.searchText()
                }
            }else{
                resetCollection()
            }
        }else{
            resetCollection()
        }
    }
    
    private func setHandler(){
        var emojis: [Emoji] = []
        for i in fullCategories{
            let emojiStrings = i.emojis
            let _ = emojiStrings?.map({
                emojis.append(fullEmojis[$0]!)
            })
        }
        searchHandler = EmojiSearchHandler(emojiModel: emojis)
    }
    
    private func searchText(){
        let text = searchTextField.text ?? ""
        let emojis = searchHandler.searchEmoji(searchtext: text)
        self.categories = [Category(id: nil, name: "Search result", emojis: emojis)]
        categoryLabel.text = "Search result"
        categoryCollectionView.reloadData()
    }
    
    private func resetCollection(){
        categories = fullCategories
        categoryDataSource = fullEmojis
        categoryCollectionView.reloadData()
    }
    
    private func initCollection(){
        let emojis = CommonLRUHandler.shared.getAllValues()
        self.categories.insert(Category(id: nil, name: "Sık Kullanılanlar", emojis: emojis), at: 0)
    }
    
    private func setUpTextfield(){
//        let placeholderColor = DioCommonThemeHandler.shared.getReverseBasicColor()
        searchTextField.layer.borderWidth = 1
//        searchTextField.layer.borderColor = borderColor.cgColor
        searchTextField.layer.cornerRadius = 7
        searchTextField.setLeftPaddingPoints(8)
//        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
//        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        searchTextField.setSearchImage()
        searchTextField.setTopBar()
    }
    
    private func setGestureRecognizer(){
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        recognizer.direction = .down
        self.view.addGestureRecognizer(recognizer)
    }
    
    
    private func fetchEmojiCategories(){
        if let path = Bundle.main.path(forResource: "emoji", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(EmojiModel.self, from: data)
                self.categories = jsonResult.data?.categories
                self.fullCategories = jsonResult.data?.categories
                self.categoryDataSource = jsonResult.data?.emojis
                self.fullEmojis = jsonResult.data?.emojis
              } catch {
                   // handle error
              }
        }
    }
    
    private func setObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.bottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func swipeAction(){
        EmojiPickerHandler.shared.hideEmojiPicker()
    }
}

extension VCEmojiPicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        var emojiDataSource:[String] = []
        if categories[indexPath.row].name == "Sık Kullanılanlar"{
            let emojNames: [String] = CommonLRUHandler.shared.getAllValues()
            emojiDataSource = emojNames
        }else if categories[indexPath.row].name == "Search result"{
            let emojNames = categories.first?.emojis
            emojiDataSource = emojNames ?? []
        }else{
            let emojNames: [String] = categories[indexPath.row].emojis ?? []
            for i in emojNames{
                emojiDataSource.append(categoryDataSource[i]?.e ?? "")
            }
        }
        cell.completion = self.completion
        cell.dataSource = emojiDataSource
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return categoryCollectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = categoryCollectionView.contentOffset
        visibleRect.size = categoryCollectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = categoryCollectionView.indexPathForItem(at: visiblePoint) else { return }
        let width: CGFloat = slideIndicator.frame.width + categoryStackView.spacing
        let value = CGFloat(indexPath.row) * width
        categoryLabel.text = categories[indexPath.row].name ?? ""
        UIView.animate(withDuration: 0.2) {
            self.sliderViewLeadingConstraint.constant = CGFloat(value)
            self.view.layoutIfNeeded()
        }
        
        categoryCollectionView.reloadData()
    }
}



