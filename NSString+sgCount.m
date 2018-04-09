//
//  NSString+sgCount.m
//  ChartsLength
//
//  Created by sungrow on 2018/4/8.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import "NSString+sgCount.h"

static const NSInteger sgByteCount = 2;

@implementation NSString (sgCount)

/**
 计算文本长度
 汉字为双字节
 
 @return 文本长度
 */
- (NSUInteger)sgCount {
    NSUInteger count = 0;
    for (int i = 0; i<[self length]; i++) {
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        count += s.isDoubleByte ? sgByteCount : 1;
    }
    return count;
}

/**
 返回超过最大字符数的字符下标
 例: "123最大字符数ABC"  限制长度为10
 结果: 返回 6
 
 @param sgCount 限制长度
 @return 超过限制长度的字符临界下标
 */
- (NSUInteger)indexWithSgCount:(NSInteger)sgCount {
    NSUInteger count = 0;
    for (int i = 0; i<[self length]; i++) {
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        count += s.isDoubleByte ? sgByteCount : 1;
        if (count > sgCount) {
            return i;
        }
    }
    return NSNotFound;
}

/**
 判断单个字符是否是双字节字符
 匹配双字节的正则表达式为: "[^\x00-\xff]"
 
 @return 是否是双字节字符
 */
- (BOOL)isDoubleByte {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"[^\\x00-\\xff]" options:0 error:nil];
    NSArray *matches = [regularExpression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return matches.count > 0;
}

@end
