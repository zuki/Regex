//
//  PatternTests.swift
//  Regex
//
//  Created by Ryosuke Hayashi on 2015/11/04.
//  Copyright © 2015年 hayashikun. All rights reserved.
//

import XCTest

class RatternTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmail() {
        XCTAssert("hoge@hoge.com".find(Pattern.email, mode: FindMode.regularExpression))
        XCTAssert("hoge_123+12@hoge.com".find(Pattern.email, mode: FindMode.regularExpression))
        XCTAssertFalse("hoge_123+12hoge.com".find(Pattern.email, mode: FindMode.regularExpression))
        XCTAssertFalse("hoge_123+12hoge.com".find(Pattern.email, mode: FindMode.regularExpression))
        XCTAssertFalse("hoge_123+12@hoge".find(Pattern.email, mode: FindMode.regularExpression))
    }
}
