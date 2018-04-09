//
//  NSString+sgCount.m
//  ChartsLength
//
//  Created by sungrow on 2018/4/8.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import "NSString+sgCount.h"

@implementation NSString (sgCount)

/**
 替换双字节长度的文本为 "**", 然后计算文本长度
 汉字为双字节
 匹配双字节的正则表达式为: "[^\x00-\xff]"

 @return 文本长度
 */
- (NSUInteger)sgCount {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"[^\\x00-\\xff]" options:0 error:nil];
    NSUInteger count = [regularExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@"**"].length;
    return count;
}

@end
