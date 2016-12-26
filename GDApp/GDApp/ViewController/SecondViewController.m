//
//  SecondViewController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "SecondViewController.h"

#define TextView_X     1
#define TextView_Heigh 30

@interface SecondViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputView;

@end

@implementation SecondViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNot];
    [self setupUI];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UI

- (void)setupUI {
    [self.view addSubview:self.inputView];
    
}

- (void)registerNot {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldChnage:) name:UITextViewTextDidChangeNotification object:nil];


}

#pragma mark - @selector

-(void)KeyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //获取高度
    NSValue *value = [info objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;
    float keyboardHeight = keyboardSize.height;
    // 获取键盘弹出的时间
    NSValue *animationDurationValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    //自定义的frame大小的改变的语句
    _inputView.frame = CGRectMake( TextView_X, GD_Screen_Height - keyboardHeight - GD_StateBar_Heigh - GD_NavigationBar_Heigh - TextView_Heigh, GD_Screen_Width - 2 * TextView_X, TextView_Heigh);
}

- (void)TextFieldChnage:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    GDLog(@" - - - %@",info);
}

#pragma mark - TextViewDelegate 

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _inputView.text = @"放松放松的方式发生";
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _inputView.frame = CGRectMake(TextView_X, GD_Screen_Height - GD_NavigationBar_Heigh - GD_StateBar_Heigh - GD_TableBar_Heigh - TextView_Heigh, GD_Screen_Width - 2 * TextView_X, TextView_Heigh);
    
}

//点击右下角回弹键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - property

- (UITextView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UITextView alloc] init];
        _inputView.frame = CGRectMake(TextView_X, GD_Screen_Height - GD_NavigationBar_Heigh - GD_StateBar_Heigh - GD_TableBar_Heigh - TextView_Heigh, GD_Screen_Width - 2 * TextView_X, TextView_Heigh);
        _inputView.text = @"";
        _inputView.font = [UIFont systemFontOfSize:14];
        _inputView.textColor = [UIColor purpleColor];
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.keyboardType = UIKeyboardTypeDefault;
        _inputView.textAlignment = NSTextAlignmentLeft;
        _inputView.scrollEnabled = NO;
        //_inputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        _inputView.delegate = self;
        _inputView.layer.borderColor = [UIColor orangeColor].CGColor;
        _inputView.layer.borderWidth = 1;
        _inputView.layer.cornerRadius = 4;
        _inputView.layer.masksToBounds = YES;
    }
    return _inputView;
}

 
@end
