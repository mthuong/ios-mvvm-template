//
//  NSMutableAttributedString+Extension.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 14 }
    var boldFont: UIFont  { return UIFont.systemFont(ofSize: fontSize, weight: .bold) }
    
    var normalFont: UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
