//
//  ThirdViewController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "ThirdViewController.h"
#import <objc/runtime.h>

#define ImageView_Tag 1000

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UI

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.tag = ImageView_Tag;
    imageView.image = [UIImage imageNamed:@"liveSelected"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
}

CGPoint originalLocation;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    originalLocation = [touch locationInView:self.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    CGRect frame = self.view.frame;
    frame.origin.x += currentLocation.x-originalLocation.x;
    frame.origin.y += currentLocation.y-originalLocation.y;
    self.view.frame = frame;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    //UITouch *touch = [touches anyObject];
//    NSTimer *timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

@end
