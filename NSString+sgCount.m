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

#pragma mark - public func
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

/**
 处理输入框统计文本

 @param inputView 输入控件
 @param maxCount 限制长度
 @param doubleByteLimit 是否使用双字节限制
 @param textDidChanged 文本发生改变的回调(参数列表: 是否超出限制, 文本框)
 */
+ (void)dealInputValueWith:(UIView<UITextInput> *)inputView maxCount:(NSInteger)maxCount doubleByteLimit:(BOOL)doubleByteLimit textDidChanged:(void(^)(bool beyongLimit, UIView<UITextInput> *inputView))textDidChanged {
    UITextRange *selectedRange = [inputView markedTextRange];
    //获取高亮部分
    UITextPosition *position = [inputView positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        bool beyond = [self beyondLimit:inputView maxCount:maxCount doublueByteLimit:doubleByteLimit];
        if (textDidChanged) {
            textDidChanged(beyond, inputView);
        }
    }
}

#pragma mark - private func

/**
 kvc 设置 text
 
 @param text text
 @param inputView 输入控件
 */
+ (void)setText:(NSString *)text inputView:(UIView *)inputView {
    if ([inputView valueForKey:@"text"] && text) {
        [inputView setValue:text forKey:@"text"];
    }
}

/**
 kvc 获取 text
 
 @param inputView 输入控件
 @return text
 */
+ (NSString *)getText:(UIView *)inputView {
    if ([inputView valueForKey:@"text"]) {
        return [inputView valueForKey:@"text"];
    }
    return @"";
}

+ (bool)beyondLimit:(UIView<UITextInput> *)inputView maxCount:(NSInteger)maxCountValue doublueByteLimit:(BOOL)doubleByteLimit {
    // 默认使用系统字符长度统计
    NSInteger textCount = [self getText:inputView].length;
    NSInteger maxCount = maxCountValue;
    // 若设置使用双字节统计字符, 则更新限制
    if (doubleByteLimit) {
        textCount = [self getText:inputView].sgCount;
        maxCount = [[self getText:inputView] indexWithSgCount:maxCountValue];
    }
    if (textCount > maxCount) {
        NSRange rangeIndex = [[self getText:inputView] rangeOfComposedCharacterSequenceAtIndex:maxCount];
        if (rangeIndex.length == 1) {
            [self setText:[[self getText:inputView] substringToIndex:maxCount] inputView:inputView];
        } else {
            NSRange rangeRange = [[self getText:inputView] rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxCount)];
            [self setText:[[self getText:inputView] substringWithRange:rangeRange] inputView:inputView];
        }
        return YES;
    }
    return NO;
}

/**
 格式化字符串
 
 NSString *s = [NSString stringWithSGFormat:@"---%2@ --- %4@ --- %3@", @"123", @"456", @"7890", @"abcdef", @"jhkl"];
 result: ---- s = ---123 --- 7890 --- 456
 
 @param format 格式化字符
 @return 格式化字符串
 */
+ (instancetype)stringWithSGFormat:(NSString *)format, ... {
    NSError *error = nil;
    NSRegularExpression *regularExp = [NSRegularExpression regularExpressionWithPattern:@"(%\\d@)" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error == nil) {
        NSArray <NSTextCheckingResult *>*matches = [regularExp matchesInString:format options:0 range:NSMakeRange(0, format.length)];
        NSMutableDictionary *resultPair = [NSMutableDictionary dictionary];
        for (NSTextCheckingResult *result in matches) {
            NSString *str1 = [format substringWithRange:result.range];
            NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"@" withString:@"$@"];
            [resultPair setObject:str2 forKey:str1];
            NSLog(@"------ str1 = %@; ----- str2 = %@", str1, str2);
        }
        for (NSString *key in resultPair.allKeys) {
            format = [format stringByReplacingOccurrencesOfString:key withString:resultPair[key]];
        }
        NSLog(@"------ format = %@", format);
    }
    va_list vaList;
    va_start(vaList, format);
    NSString *s = [[NSString alloc] initWithFormat:format arguments:vaList];
    va_end(vaList);
    return s;
}

@end
