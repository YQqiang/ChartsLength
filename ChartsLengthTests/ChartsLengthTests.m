//
//  ChartsLengthTests.m
//  ChartsLengthTests
//
//  Created by sungrow on 2018/4/9.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+sgCount.h"

@interface ChartsLengthTests : XCTestCase

@end

@implementation ChartsLengthTests

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
    NSUInteger index = NSNotFound;
    NSUInteger maxCount = test.sgCount;
    XCTAssertEqual([test indexWithSgCount:maxCount], index);
}

- (void)testIndexWithSgCount3 {
    NSString *test = @"123最大字符数ABC";
    NSUInteger index = NSNotFound;
    NSUInteger maxCount = 17;
    XCTAssertEqual([test indexWithSgCount:maxCount], index);
}

- (void)testI18N_JS1 {
    NSString *format = @"{0}";
    NSString *result = [NSString i18nFormat:format, @"123"];
    XCTAssertEqualObjects(@"123", result);
}

- (void)testI18N_JS2 {
    NSString *format = @"{0}-{1}";
    NSString *result = [NSString i18nFormat:format, @"123", @"456"];
    XCTAssertEqualObjects(@"123-456", result);
}

- (void)testI18N_JS3 {
    NSString *format = @"{1}-{0}";
    NSString *result = [NSString i18nFormat:format, @"123", @"456"];
    XCTAssertEqualObjects(@"456-123", result);
}

- (void)testI18N_JS4 {
    NSString *format = @"{2}-{0}-{1}";
    NSString *result = [NSString i18nFormat:format, @"123", @"456", @"789"];
    XCTAssertEqualObjects(@"789-123-456", result);
}

- (void)testI18N_JS5 {
    NSString *format = @"{2}-{0}-{1}-{3}";
    NSString *result = [NSString i18nFormat:format, @"123", @"456", @"789", @"abc"];
    XCTAssertEqualObjects(@"789-123-456-abc", result);
}

- (void)testI18N_OC1 {
    NSString *format = @"%@";
    NSString *result = [NSString i18nFormat:format, @"123"];
    XCTAssertEqualObjects(@"123", result);
}

- (void)testI18N_OC2 {
    NSString *format = @"%1@-%2@";
    NSString *result = [NSString i18nFormat:format, @"123", @"456"];
    XCTAssertEqualObjects(@"123-456", result);
}

- (void)testI18N_OC3 {
    NSString *format = @"%2@-%1@";
    NSString *result = [NSString i18nFormat:format, @"123", @"456"];
    XCTAssertEqualObjects(@"456-123", result);
}

- (void)testI18N_OC4 {
    NSString *format = @"%3@-%1@-%2@";
    NSString *result = [NSString i18nFormat:format, @"123", @"456", @"789"];
    XCTAssertEqualObjects(@"789-123-456", result);
}

- (void)testI18N_OC5 {
    NSString *format = @"%3@-%1@-%2@-%4@";
    NSString *result = [NSString i18nFormat:format, @"123", @"456", @"789", @"abc"];
    XCTAssertEqualObjects(@"789-123-456-abc", result);
}


@end
