//
//  ViewController.m
//  TestSepTextField
//
//  Created by DHLau on 16/8/24.
//  Copyright © 2016年 DHLau. All rights reserved.
//

#import "ViewController.h"
#import "DHSepatateTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DHSepatateTextField *textField = [DHSepatateTextField textFieldWithSquareAmount:5];
    textField.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
    textField.squareAmount = 5;
    [textField setFinishEdit:^(NSString *str) {
        NSLog(@"完成后的Str - %@", str);
    }];
    [self.view addSubview:textField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
