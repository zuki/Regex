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
    func extract(pattern: String, options: NSRegularExpressionOptions = .AnchorsMatchLines) -> [[String]] {
        var allMatches = [[String]]()
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return []
        }
        let nsStr = self as NSString
        regex.enumerateMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: nsStr.length)) {
            (result: NSTextCheckingResult?, flags, ptr) -> Void in
            if let result = result {
                var matches = [String]()
                for index in 0...result.numberOfRanges - 1 {
                    let range = result.rangeAtIndex(index)
                    matches.append(nsStr.substringWithRange(range))
                }
                allMatches.append(matches)
            }
        }
        return allMatches
    }
    
    func split(str: String, mode: FindMode) -> [String] {
        switch mode {
        case .Literal:
            return self.componentsSeparatedByString(str)
        case .CaseInsensitive:
            let toLow = self.replace(str, new: str.lowercaseString, mode: .CaseInsensitive)
            return toLow.componentsSeparatedByString(str.lowercaseString)
        case .RegularExpression:
            var splitResult = [String]()
            guard let regex = try? NSRegularExpression(pattern: str, options: .AnchorsMatchLines) else {
                return []
            }
            let nsStr = self as NSString
            var start = 0
            regex.enumerateMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: nsStr.length)) {
                (result: NSTextCheckingResult?, flags, ptr) -> Void in
                if let result = result {
                    let range = NSRange(location: start, length: result.range.location - start)
                    splitResult.append(nsStr.substringWithRange(range))
                    start = result.range.location + result.range.length
                }
            }
            splitResult.append(nsStr.substringFromIndex(start))
            return splitResult
        }
        
    }
    
    func find(str: String, mode: FindMode) -> Bool {
        switch mode {
        case .Literal:
            return self.containsString(str)
        case .CaseInsensitive:
            return self.lowercaseString.containsString(str.lowercaseString)
        case .RegularExpression:
            guard let regex = try? NSRegularExpression(pattern: str, options: .AnchorsMatchLines) else {
                return false
            }
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: (self as NSString).length)) != nil
        }
    }
    
    func replace(old: String, new: String, mode: FindMode) -> String {
        let options = [
            NSStringCompareOptions.RegularExpressionSearch,
            NSStringCompareOptions.LiteralSearch,
            NSStringCompareOptions.CaseInsensitiveSearch
        ][mode.hashValue]
        return self.stringByReplacingOccurrencesOfString(old, withString: new, options: options, range: nil)
    }
}