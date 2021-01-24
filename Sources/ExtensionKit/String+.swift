//
//  String+.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//
import Foundation

public extension String {
    var localized: String {
        let bundle = Bundle.main
        return NSLocalizedString(self,
                                 tableName: ExtensionKit.localised.fileName,
                                 bundle: bundle,
                                 value: ExtensionKit.localised.value,
                                 comment: ExtensionKit.localised.comment)
    }
}

public extension String {
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

#if os(iOS)

import UIKit

public extension String {
    // for Multi Line
    func sizeofText(withConstrainedSize constraintSize: CGSize, font: UIFont) -> CGSize {
        if (self.isEmpty) { return CGSize.zero }
        let boundingBox = self.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        let finalSize = CGSize(width: boundingBox.width, height: boundingBox.height)
        return finalSize
    }
    
    func sizeOfText(font: UIFont) -> CGSize {
        if (self.isEmpty) { return CGSize.zero }
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        
        let finalSize = CGSize(width: ceil(size.width), height: ceil(size.height))
        return finalSize;
    }
}


public extension NSMutableAttributedString {
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        let range:NSRange?
        if let text = textToFind {
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)        }
    }
}


#endif

