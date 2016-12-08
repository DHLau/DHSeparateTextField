//
//  DHSeparateTextField.m
//  DHSeparateTextField
//
//  Created by DHLau on 16/8/24.
//  Copyright © 2016年 DHLau. All rights reserved.
//

#import "DHSeparateTextField.h"

#define SQUARE_FOCUS_COLOR [UIColor orangeColor]
#define SQUARE_DEFAULT_COLOR [UIColor lightGrayColor]

@interface DHSeparateTextField()<UITextFieldDelegate>

/** 输入框 */
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *labelsArray;

@property (nonatomic, strong) NSMutableArray *textArray;

@end

static const CGFloat commonMargin = 10;

@implementation DHSeparateTextField


+ (instancetype)textFieldWithSquareAmount:(NSInteger)squareAmount
{
    DHSeparateTextField *textField = [[DHSeparateTextField alloc] init];
    textField.squareAmount = squareAmount == (0 || nil) ? 6 : squareAmount;
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 默认是6个格子
        self.squareAmount = 6;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        // 默认是6个格子
        self.squareAmount = 6;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    // 创建真实输入框（用户其实看不到）
    self.textField = [[UITextField alloc] init];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.textField];
    
    // 创建虚拟的输入框
    
    for (NSInteger i = 0; i < self.squareAmount; i++) {
        UILabel *squareLabel = [self creatSquareLabel];
        [self addSubview:squareLabel];
    }
}

- (UILabel *)creatSquareLabel
{
    UILabel *squareLabel = [[UILabel alloc] init];
    squareLabel.layer.borderWidth = 1;
    squareLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    squareLabel.text = @"";
    squareLabel.textAlignment = UITextAlignmentCenter;
    squareLabel.textColor = [UIColor lightGrayColor];
    return squareLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelsArray = @[].mutableCopy;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [self.labelsArray addObject:view];
        }
    }
    
    // label的宽度
    CGFloat labelW = (self.frame.size.width - (self.labelsArray.count + 1) * commonMargin) / self.labelsArray.count;
    
    for (NSInteger i = 0; i < self.labelsArray.count ; i++) {
        UILabel *label = self.self.labelsArray[i];
        label.frame = CGRectMake(commonMargin * (i + 1) + labelW * i,
                                 0,
                                 labelW,
                                 labelW);
    }
}

- (void)setSquareAmount:(NSInteger)squareAmount
{
    _squareAmount = squareAmount;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self setup];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - EVENT
#pragma mark ----------------------------------------
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.textField.isFirstResponder == YES) {
        [self hideKeyboard];
    } else {
        [self showKeyboard];
    }
}

- (void)hideKeyboard
{
    [self.textField resignFirstResponder];
}

- (void)showKeyboard
{
    [self.textField becomeFirstResponder];
    [self textFieldTextChange:self.textField];
}

- (void)textFieldTextChange:(UITextField *)textField
{
    textField.text = textField.text.length > self.squareAmount ? [textField.text substringToIndex:self.squareAmount] : textField.text;
    NSString *text = textField.text;
    
    for (UILabel *label in self.labelsArray) {
        label.text = @"";
        label.layer.borderColor = SQUARE_DEFAULT_COLOR.CGColor;
        label.textColor = SQUARE_DEFAULT_COLOR;
    }
    
    for (NSInteger i = 0; i < textField.text.length; i++) {
        NSString *str = [text substringToIndex:1];
        text = [text substringFromIndex:1];
        UILabel *label = self.labelsArray[i];
        label.text = str;
    }
    
    for (UILabel *label in self.labelsArray) {
        if ([label.text isEqualToString:@""] || [label.text isEqualToString:@"|"]) {
            label.text = @"|";
            label.textColor = SQUARE_FOCUS_COLOR;
            label.layer.borderColor = SQUARE_FOCUS_COLOR.CGColor;
            break;
        } else {
            label.textColor = SQUARE_DEFAULT_COLOR;
            label.layer.borderColor = SQUARE_DEFAULT_COLOR.CGColor;
        }
    }
    
    if (textField.text.length == self.labelsArray.count) {
        if (self.FinishEdit) {
            self.FinishEdit(self.textField.text);
        }
    }
}

@end
