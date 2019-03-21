//
//  TSTagLabel.swift
//  TsgsSelector
//
//  Created by Yusuke SAITO on 2019/03/20.
//

import UIKit

class TSTagLabel: UILabel {
    
    var _tag: TSTag?
    var properties: TSTagProperties
    
    var isSelected = false {
        didSet {
            if isSelected {
                self.backgroundColor = self.properties.selectedColor
            } else {
                self.backgroundColor = self.properties.color
            }
        }
    }
    
    var didPushAction:((Bool) -> Void)?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        self.properties = TSTagProperties()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.properties = TSTagProperties()
        super.init(coder: aDecoder)
    }
    
    init(tag: TSTag, properties: TSTagProperties) {
        self.properties = properties
        super.init(frame: CGRect(x:0, y:0, width:100, height:100))
        self.isUserInteractionEnabled = true
        self._tag = tag
        self.text = tag.id
        self.isSelected = tag.isSelected
        self.backgroundColor = tag.isSelected ? properties.selectedColor : properties.color
        self.font = properties.font
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.layer.cornerRadius = properties.cornerRadius
        self.layer.borderColor = properties.borderColor.cgColor
        self.layer.borderWidth = properties.borderWidth
        self.sizeToFit()
    }
    
    // MARK:- Overrides
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.isSelected = !self.isSelected
        self.didPushAction?(self.isSelected)
    }
    
}

