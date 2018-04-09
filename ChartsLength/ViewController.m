//
//  ViewController.m
//  ChartsLength
//
//  Created by sungrow on 2018/4/9.
//  Copyright © 2018年 sungrow. All rights reserved.
//

#import "ViewController.h"
#import "NSString+sgCount.h"

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *doubleByteLimitSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    self.textView.text = @"测试字符";
    [self textViewDidChange:self.textView];
}
- (IBAction)doubleByteLimitAction:(UISwitch *)sender {
    [self textViewDidChange:self.textView];
}

- (BOOL)doubleByteLimit {
    return self.doubleByteLimitSwitch.isOn;
}

- (NSUInteger)maxTextCount {
    return 10;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSInteger max = self.maxTextCount;
    NSInteger doubleByteLimit = self.doubleByteLimit;
    [NSString dealInputValueWith:textView maxCount:max doubleByteLimit:doubleByteLimit textDidChanged:^(bool isZh, bool beyongLimit, UIView<UITextInput> *inputView) {
        if (self.doubleByteLimit) {
            self.messageLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.textView.text.sgCount, max];
        } else {
            self.messageLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.textView.text.length, max];
        }
    }];
}


@end
