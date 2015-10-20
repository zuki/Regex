//
//  Regex.swift
//  Regex
//
//  Created by Ryosuke Hayashi on 2015/10/20.
//  Copyright © 2015年 hayashikun. All rights reserved.
//

import Foundation

enum FindMode {
    case RegularExpression
    case Literal
    case CaseInsensitive
}

extension String {
    func replace(old: String, new: String, mode: FindMode) -> String {
        let options = [
            NSStringCompareOptions.RegularExpressionSearch,
            NSStringCompareOptions.LiteralSearch,
            NSStringCompareOptions.CaseInsensitiveSearch
        ][mode.hashValue]
        return self.stringByReplacingOccurrencesOfString(old, withString: new, options: options, range: nil)
    }
}