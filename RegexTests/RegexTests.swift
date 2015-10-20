//
//  RegexTests.swift
//  RegexTests
//
//  Created by Ryosuke Hayashi on 2015/10/20.
//  Copyright © 2015年 hayashikun. All rights reserved.
//

import XCTest

class RegexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExtract() {
        XCTAssertEqual("abcdefghijk".extract("b.+f"), [["bcdef"]])
        XCTAssertEqual("abcdefghijk".extract("b.*d(.*)h(.*)k"), [["bcdefghijk", "efg", "ij"]])
        XCTAssertEqual("ahogezapiyozafugoz".extract("a(.*)z"), [["ahogezapiyozafugoz", "hogezapiyozafugo"]])
        XCTAssertEqual("ahogezapiyozafugoz".extract("a(.*?)z"), [["ahogez", "hoge"], ["apiyoz", "piyo"], ["afugoz", "fugo"]])
    }
    
    func testReplace() {
        XCTAssertEqual("abcdcab".replace("ab", new: "f", mode: FindMode.RegularExpression), "fcdcf")
        XCTAssertEqual("abcdcab".replace("^ab", new: "f", mode: FindMode.RegularExpression), "fcdcab")
        XCTAssertEqual("a334a".replace("\\d+", new: "han", mode: FindMode.RegularExpression), "ahana")
        XCTAssertEqual("abcdefg".replace("[ceg]", new: "h", mode: FindMode.RegularExpression), "abhdhfh")
        XCTAssertEqual("AbCdEfG".replace("[a-z]", new: "h", mode: FindMode.RegularExpression), "AhChEhG")
        XCTAssertEqual("abc\ndef".replace(".+", new: "h", mode: FindMode.RegularExpression), "h\nh")
        XCTAssertEqual("abc def".replace(".+", new: "h", mode: FindMode.RegularExpression), "h")
        XCTAssertEqual("abc\ndef".replace("[\\s]+", new: "h", mode: FindMode.RegularExpression), "abchdef")
        XCTAssertEqual("abc\ndef".replace("[a-z\\n]+", new: "h", mode: FindMode.RegularExpression), "h")
        XCTAssertEqual("\n \t \n".replace("\\s", new: "c", mode: FindMode.RegularExpression), "ccccc")
        XCTAssertEqual("\n \t \n".replace(" ", new: "c", mode: FindMode.RegularExpression), "\nc\tc\n")
        XCTAssertEqual("abcdefg".replace("a.c", new: "hhh", mode: FindMode.RegularExpression), "hhhdefg")
        XCTAssertEqual("abcdefg".replace("b.*", new: "hhh", mode: FindMode.RegularExpression), "ahhh")
        XCTAssertEqual("abcdefg".replace("b.*?", new: "hhh", mode: FindMode.RegularExpression), "ahhhcdefg")
        XCTAssertEqual("abcdefg".replace("abc", new: "hhh", mode: FindMode.Literal), "hhhdefg")
        XCTAssertEqual("aBcdefg".replace("abc", new: "hhh", mode: FindMode.Literal), "aBcdefg")
        XCTAssertEqual("aBcdefg".replace("abc", new: "hHh", mode: FindMode.CaseInsensitive), "hHhdefg")
    }
}
