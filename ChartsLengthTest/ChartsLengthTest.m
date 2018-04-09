//
//  sgCountTest.m
//  sgCountTest
//
//  Created by sungrow on 2018/4/8.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+sgCount.h"

@interface sgCountTest : XCTestCase

@end

@implementation sgCountTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testsgCount1 {
    NSString *test = @"123456789";
    NSUInteger length = 9;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount2 {
    NSString *test = @"阳光云";
    NSUInteger length = 6;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount3 {
    NSString *test = @"阳光云abc";
    NSUInteger length = 9;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount4 {
    NSString *test = @"!@#";
    NSUInteger length = 3;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount5 {
    NSString *test = @"?><";
    NSUInteger length = 3;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount6 {
    NSString *test = @"一";
    NSUInteger length = 2;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount7 {
    NSString *test = @"日光雲";
    NSUInteger length = 6;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount8 {
    NSString *test = @"Nubes de sol";
    NSUInteger length = 12;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testsgCount9 {
    NSString *test = @"햇빛 구름";
    NSUInteger length = 9;
    XCTAssertEqual(test.sgCount, length);
}

- (void)testIndexWithSgCount1 {
    NSString *test = @"123最大字符数ABC";
    NSUInteger index = 6;
    NSUInteger maxCount = 10;
    XCTAssertEqual([test indexWithSgCount:maxCount], index);
}

- (void)testIndexWithSgCount2 {
    NSString *test = @"123最大字符数ABC";
    NSUInteger index = 10;
    NSUInteger maxCount = 16;
    XCTAssertEqual([test indexWithSgCount:maxCount], index);
}

- (void)testIndexWithSgCount3 {
    NSString *test = @"123最大字符数ABC";
    NSUInteger index = NSNotFound;
    NSUInteger maxCount = 17;
    XCTAssertEqual([test indexWithSgCount:maxCount], index);
}


@end
