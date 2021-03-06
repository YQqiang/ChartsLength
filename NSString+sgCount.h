//
//  NSString+sgCount.h
//  ChartsLength
//
//  Created by sungrow on 2018/4/8.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (sgCount)

- (NSUInteger)sgCount;

- (NSUInteger)indexWithSgCount:(NSInteger)sgCount;

+ (void)dealInputValueWith:(UIView<UITextInput> *)inputView maxCount:(NSInteger)maxCount doubleByteLimit:(BOOL)doubleByteLimit textDidChanged:(void(^)(bool beyongLimit, UIView<UITextInput> *inputView))textDidChanged;

+ (NSString *)i18nFormat:(NSString *)format, ...;
- (NSString *)i18nFormatBase:(va_list)vaList;

@end
