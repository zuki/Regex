//
//  Pattern.swift
//  Regex
//
//  Created by Ryosuke Hayashi on 2015/11/04.
//  Copyright © 2015年 hayashikun. All rights reserved.
//

import Foundation

class Pattern {
    static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}+$"
    static let ipv4 = "(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})"
    
    static func url(scheme: String? = "https?") -> String {
        return "\(scheme != nil ? scheme! : "[a-z]+")://[a-zA-Z0-9\\.]+\\/[\\w-\\.\\/?%&=]*"
    }
}