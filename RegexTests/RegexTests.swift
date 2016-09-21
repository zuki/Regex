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
        // FIXME: Cannot invoke 'XCTAssertEqual' with an argument list of type '([[String]], [Array<String>])'
        //   Like: https://bugs.swift.org/browse/SR-2284
        XCTAssertEqual("abcdefghijk".extract("b.+f")[0], [["bcdef"]][0])
        XCTAssertEqual("abcdefghijk".extract("b.*d(.*)h(.*)k")[0], [["bcdefghijk", "efg", "ij"]][0])
        XCTAssertEqual("ahogezapiyozafugoz".extract("a(.*)z")[0], [["ahogezapiyozafugoz", "hogezapiyozafugo"]][0])
        XCTAssertEqual("ahogezapiyozafugoz".extract("a(.*?)z")[0], [["ahogez", "hoge"], ["apiyoz", "piyo"], ["afugoz", "fugo"]][0])
    }
    
    func testSplit() {
        XCTAssertEqual("abcdefghijk".split("bc", mode: FindMode.literal), ["a", "defghijk"])
        XCTAssertEqual("abspcdspefspg".split("sp", mode: FindMode.literal), ["ab", "cd", "ef", "g"])
        XCTAssertEqual("abSPcdSpefsPg".split("Sp", mode: FindMode.caseInsensitive), ["ab", "cd", "ef", "g"])
        XCTAssertEqual("absapcdsbpefscpg".split("s[a-z]p", mode: FindMode.regularExpression), ["ab", "cd", "ef", "g"])
        XCTAssertEqual("abspcds1a2f3pefse2iapg".split("s[a-z0-9]*p", mode: FindMode.regularExpression), ["ab", "g"])
        XCTAssertEqual("abspcds1a2f3pefse2iapg".split("s[a-z0-9]*?p", mode: FindMode.regularExpression), ["ab", "cd", "ef", "g"])
    }
    
    func testFind() {
        XCTAssertEqual("abcdefghijk".find("bcd", mode: FindMode.literal), true)
        XCTAssertEqual("abcdefghijk".find("bed", mode: FindMode.literal), false)
        XCTAssertEqual("abCdefghijk".find("BcD", mode: FindMode.caseInsensitive), true)
        XCTAssertEqual("abCdefghijk".find("BED", mode: FindMode.caseInsensitive), false)
        XCTAssertEqual("abcdefghijk".find("b.d", mode: FindMode.regularExpression), true)
        XCTAssertEqual("abcdefghijk".find("a.*k", mode: FindMode.regularExpression), true)
        XCTAssertEqual("abcdefghijk".find("a.d", mode: FindMode.regularExpression), false)
    }
    
    func testReplace() {
        XCTAssertEqual("abcdcab".replace("ab", new: "f", mode: FindMode.regularExpression), "fcdcf")
        XCTAssertEqual("abcdcab".replace("^ab", new: "f", mode: FindMode.regularExpression), "fcdcab")
        XCTAssertEqual("a334a".replace("\\d+", new: "han", mode: FindMode.regularExpression), "ahana")
        XCTAssertEqual("abcdefg".replace("[ceg]", new: "h", mode: FindMode.regularExpression), "abhdhfh")
        XCTAssertEqual("AbCdEfG".replace("[a-z]", new: "h", mode: FindMode.regularExpression), "AhChEhG")
        XCTAssertEqual("abc\ndef".replace(".+", new: "h", mode: FindMode.regularExpression), "h\nh")
        XCTAssertEqual("abc def".replace(".+", new: "h", mode: FindMode.regularExpression), "h")
        XCTAssertEqual("abc\ndef".replace("[\\s]+", new: "h", mode: FindMode.regularExpression), "abchdef")
        XCTAssertEqual("abc\ndef".replace("[a-z\\n]+", new: "h", mode: FindMode.regularExpression), "h")
        XCTAssertEqual("\n \t \n".replace("\\s", new: "c", mode: FindMode.regularExpression), "ccccc")
        XCTAssertEqual("\n \t \n".replace(" ", new: "c", mode: FindMode.regularExpression), "\nc\tc\n")
        XCTAssertEqual("abcdefg".replace("a.c", new: "hhh", mode: FindMode.regularExpression), "hhhdefg")
        XCTAssertEqual("abcdefg".replace("b.*", new: "hhh", mode: FindMode.regularExpression), "ahhh")
        XCTAssertEqual("abcdefg".replace("b.*?", new: "hhh", mode: FindMode.regularExpression), "ahhhcdefg")
        XCTAssertEqual("abcdefg".replace("abc", new: "hhh", mode: FindMode.literal), "hhhdefg")
        XCTAssertEqual("aBcdefg".replace("abc", new: "hhh", mode: FindMode.literal), "aBcdefg")
        XCTAssertEqual("aBcdefg".replace("abc", new: "hHh", mode: FindMode.caseInsensitive), "hHhdefg")
    }
}
