# DHSeparateTextField
#### An easy way to use a separate textfield

![DHSeparateTextField.gif](http://upload-images.jianshu.io/upload_images/1085768-ca60b5d14b8043c2.gif?imageMogr2/auto-orient/strip)

```objc
DHSepatateTextField *textField = [DHSepatateTextField textFieldWithSquareAmount:5];
    textField.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
    textField.squareAmount = 5;
    [textField setFinishEdit:^(NSString *str) {
        NSLog(@"完成后的Str - %@", str);
    }];
```
