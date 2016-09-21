//
//  Regex.swift
//  Regex
//
//  Created by Ryosuke Hayashi on 2015/10/20.
//  Copyright © 2015年 hayashikun. All rights reserved.
//

import Foundation

public enum FindMode {
    case regularExpression
    case literal
    case caseInsensitive
}

public extension String {
    func extract(_ pattern: String, options: NSRegularExpression.Options = .anchorsMatchLines) -> [[String]] {
        var allMatches = [[String]]()
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return []
        }
        let nsStr = self as NSString
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: nsStr.length)) {
            (result: NSTextCheckingResult?, flags, ptr) -> Void in
            if let result = result {
                var matches = [String]()
                for index in 0...result.numberOfRanges - 1 {
                    let range = result.rangeAt(index)
                    matches.append(nsStr.substring(with: range))
                }
                allMatches.append(matches)
            }
        }
        return allMatches
    }

    public func split(_ str: String, mode: FindMode) -> [String] {
        switch mode {
        case .literal:
            return self.components(separatedBy: str)
        case .caseInsensitive:
            let toLow = self.replace(str, new: str.lowercased(), mode: .caseInsensitive)
            return toLow.components(separatedBy: str.lowercased())
        case .regularExpression:
            var splitResult = [String]()
            guard let regex = try? NSRegularExpression(pattern: str, options: .anchorsMatchLines) else {
                return []
            }
            let nsStr = self as NSString
            var start = 0
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: nsStr.length)) {
                (result: NSTextCheckingResult?, flags, ptr) -> Void in
                if let result = result {
                    let range = NSRange(location: start, length: result.range.location - start)
                    splitResult.append(nsStr.substring(with: range))
                    start = result.range.location + result.range.length
                }
            }
            splitResult.append(nsStr.substring(from: start))
            return splitResult
        }

    }

    public func find(_ str: String, mode: FindMode) -> Bool {
        switch mode {
        case .literal:
            return self.contains(str)
        case .caseInsensitive:
            return self.lowercased().contains(str.lowercased())
        case .regularExpression:
            guard let regex = try? NSRegularExpression(pattern: str, options: .anchorsMatchLines) else {
                return false
            }
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: (self as NSString).length)) != nil
        }
    }

    public func replace(_ old: String, new: String, mode: FindMode) -> String {
        let options = [
            NSString.CompareOptions.regularExpression,
            NSString.CompareOptions.literal,
            NSString.CompareOptions.caseInsensitive
        ][mode.hashValue]
        return self.replacingOccurrences(of: old, with: new, options: options, range: nil)
    }
}
