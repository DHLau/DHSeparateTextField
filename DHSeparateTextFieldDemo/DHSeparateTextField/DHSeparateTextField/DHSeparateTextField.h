//
//  DHSeparateTextField.h
//  DHSeparateTextField
//
//  Created by DHLau on 16/8/24.
//  Copyright © 2016年 DHLau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHSeparateTextField : UIView

+ (instancetype)textFieldWithSquareAmount:(NSInteger)squareAmount;

/** 显示键盘 */
- (void)showKeyboard;

/** 隐藏键盘 */
- (void)hideKeyboard;

/** 方格数量 默认值为6 */
@property (nonatomic, assign) NSInteger squareAmount;

/** 完成输入的回调 */
@property (nonatomic , copy) void(^FinishEdit)(NSString *str);

@end
