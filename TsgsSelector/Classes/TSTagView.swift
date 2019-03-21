//
//  TSTagView.swift
//  TsgsSelector
//
//  Created by Yusuke SAITO on 2019/03/20.
//

import UIKit

public struct TSTagProperties {
    var vMargin: CGFloat = 10.0
    var hMargin: CGFloat = 10.0
    var tagHMargin: CGFloat = 10.0
    var tagVMargin: CGFloat = 10.0
    var tagHPadding: CGFloat = 5.0
    var tagVPadding: CGFloat = 5.0
    
    var color: UIColor = .white
    var selectedColor: UIColor = .green
    
    var font: UIFont = UIFont.systemFont(ofSize: 17.0)
    
    var cornerRadius: CGFloat = 7
    var borderColor: UIColor = .black
    var borderWidth: CGFloat = 1/UIScreen.main.scale
}

class TSTagView: UIScrollView, UIScrollViewDelegate {
    
    var tags = [TSTag]()
    var tagLabels = [TSTagLabel]()
    var textField: UITextField?
    
    let properties: TSTagProperties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        self.properties = TSTagProperties()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.properties = TSTagProperties()
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, properties: TSTagProperties) {
        self.properties = properties
        super.init(frame: frame)
    }
    
    // MARK: - privateメソッド
    
    func layoutTags(tags: [TSTag]) {
        // 現在の表示をクリア
        self.subviews.forEach { $0.removeFromSuperview() }
        
        var totalHeight = self.properties.vMargin
        var prevFrame: CGRect?
        
        self.tags = tags
        self.tagLabels = []
        
        self.textField?.text = tags
            .filter { $0.isSelected }
            .map { $0.id }
            .joined(separator: ", ")
        
        for (i, tag) in tags.enumerated() {
            let label = TSTagLabel(tag: tag, properties: self.properties)
            label.didPushAction = { isSelected -> Void in
                self.tags[i].isSelected = isSelected
                self.textField?.text = self.tags
                    .filter { $0.isSelected }
                    .map { $0.id }
                    .joined(separator: ", ")
            }
            var size = label.frame.size
            size.width += self.properties.tagHPadding*2
            size.height += self.properties.tagVPadding*2
            
            if totalHeight == self.properties.vMargin { // 初めの一つ目
                label.frame = CGRect(x:self.properties.hMargin, y: self.properties.vMargin, width: size.width, height: size.height)
                totalHeight = self.properties.vMargin + size.height
                prevFrame = label.frame
                
            } else {
                let f = prevFrame!
                let x = f.origin.x + f.width + self.properties.tagHMargin
                if self.frame.width < x + size.width { // 横幅に収まりきらない場合
                    label.frame = CGRect(x: self.properties.hMargin, y: totalHeight + self.properties.tagVMargin, width: size.width, height: size.height)
                    totalHeight += self.properties.tagVMargin + size.height
                    prevFrame = label.frame
                    
                } else { // 収まる場合
                    label.frame = CGRect(x:x, y:f.origin.y, width: size.width, height: size.height)
                    prevFrame = label.frame
                }
            }
            self.tagLabels.append(label)
            self.addSubview(label)
        }
        
        self.contentSize = CGSize(width:self.frame.width, height:totalHeight + self.properties.vMargin)
    }
}

