//
//  TSTagBar.swift
//  TsgsSelector
//
//  Created by Yusuke SAITO on 2019/03/20.
//

import UIKit

let ACCESORY_VIEW_HEIGHT: CGFloat = 260

@IBDesignable
public class TSTagBar: UISearchBar {
    
    public let tagProperties = TSTagProperties()
    
    var searchField: UITextField?
    var tagView: TSTagView?
    
    // MARK: - Public
    public var tags = [TSTag]()
    
    // MARK: - Initializer
    
    func setup() {
        self.delegate = self
        
        let bundle = Bundle(for: TSTagBar.self)
        if let img = UIImage(named: "tags-solid", in: bundle, compatibleWith: nil) {
            self.setImage(img, for: .search, state: .normal)
            // resize icon 14x14 -> 15x(15*384/480)
            for v1 in self.subviews {
                for v2 in v1.subviews {
                    if let searchField = v2 as? UITextField
                        , let searchIconImageView = searchField.leftView
                    {
                        let width = searchIconImageView.frame.size.width + 1
                        let height = 384*width/480
                        let adjust = (width - height) / 2
                        searchIconImageView.frame = CGRect(x: searchIconImageView.frame.origin.x, y: searchIconImageView.frame.origin.y+adjust, width: width, height: height)
                    }
                }
            }
        } else {
            print("cannot get the tag icon from the bundle")
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Private Methods
    
    /**
     * Create custom AccessoryView.
     */
    func createCustomInputAccessoryView() -> UIView {
        let screenSize = UIScreen.main.bounds
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width:screenSize.width, height: 44))
        
        let btnUndo = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(TSTagBar.buttonUndoDidPush(sender:)))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TSTagBar.buttonDoneDidPush(sender:)))
        
        toolBar.setItems([btnUndo, spacer, btnDone], animated: false)
        
        return toolBar
    }
    
    /**
     * Create custom inputView.
     */
    func createCustomInputView(textField: UITextField) -> UIView {
        let screenSize = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x:0, y:0, width:screenSize.width, height: ACCESORY_VIEW_HEIGHT))
        
        let tagView = TSTagView(frame: view.frame, properties: self.tagProperties)
        tagView.textField = textField
        tagView.layoutTags(tags: tags)
        self.tagView = tagView
        view.addSubview(tagView)
        
        return view
    }
    
    // MARK: - Actions
    
    @objc func buttonUndoDidPush(sender: UIBarButtonItem) {
        // initializing
        if let tagView = self.tagView {
            tagView.layoutTags(tags: tags)
        }
    }
    
    @objc func buttonDoneDidPush(sender: UIBarButtonItem) {
        self.searchField?.resignFirstResponder()
        self.endEditing(true)
        
        if let tagView = self.tagView {
            print("\(tagView.tags)")
            self.tags = tagView.tags
        }
    }
}

// MARK: - Implementation for UITextFieldDelegate
    
extension TSTagBar : UITextFieldDelegate {
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        for i in 0..<tags.count {
            tags[i].isSelected = false
        }
        
        if let tagView = self.tagView {
            tagView.layoutTags(tags: tags)
        }
        
        return true
    }
}

// MARK: - Implementation for UISearchBarDelegate
    
extension TSTagBar : UISearchBarDelegate {
    /**
     UISearchBarが持つUISearchTextField（UITextFieldのサブクラス）を特定し、そのinputViewを独自のものに変更している。
     */
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        for v1 in self.subviews {
            for v2 in v1.subviews {
                if let searchField = v2 as? UITextField {
                    searchField.delegate = self
                    searchField.inputAccessoryView = self.createCustomInputAccessoryView()
                    searchField.inputView = self.createCustomInputView(textField: searchField)
                    self.searchField = searchField
                }
            }
        }
        self.setShowsCancelButton(true, animated: true)
        return true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(false, animated: true)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
