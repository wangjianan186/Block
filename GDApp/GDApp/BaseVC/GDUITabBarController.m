//
//  GDUITabBarController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "GDUITabBarController.h"
#import "GDUINavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "UIViewController+LxTabBadgePoint.m"

#define Tab_TinTColor [UIColor colorWithRed:0.36 green:0.76 blue:0.75 alpha:1]

@interface GDUITabBarController ()

@end

@implementation GDUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  Default LaunchScreen 延迟显示  如要加动画显示 则废弃默认 Default。在你的第一个加载页面中 加入想要的动画和图片 UIPasteboard(复制板)
     */
    [NSThread sleepForTimeInterval:0.25f];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FirstViewController      *fVC   = [[FirstViewController alloc] init];
    GDUINavigationController *nVC1  = [[GDUINavigationController alloc] initWithRootViewController:fVC];
    SecondViewController     *sVC   = [[SecondViewController alloc] init];
    GDUINavigationController *nVC2  = [[GDUINavigationController alloc] initWithRootViewController:sVC];
    ThirdViewController      *tVC   = [[ThirdViewController alloc] init];
    GDUINavigationController *nVC3  = [[GDUINavigationController alloc] initWithRootViewController:tVC];
    FourthViewController     *foVC  = [[FourthViewController alloc] init];
    GDUINavigationController *nVC4  = [[GDUINavigationController alloc] initWithRootViewController:foVC];
 
    nVC1.tabBarItem.title = @"一环";
    nVC2.tabBarItem.title = @"二环";
    nVC3.tabBarItem.title = @"三环";
    nVC4.tabBarItem.title = @"四环";
    
    nVC1.tabBarItem.image = [UIImage imageNamed:@"live"];
    nVC2.tabBarItem.image = [UIImage imageNamed:@"live"];
    nVC3.tabBarItem.image = [UIImage imageNamed:@"live"];
    nVC4.tabBarItem.image = [UIImage imageNamed:@"live"];
   
    nVC1.tabBarItem.selectedImage = [UIImage imageNamed:@"liveSelected"];
    nVC2.tabBarItem.selectedImage = [UIImage imageNamed:@"liveSelected"];
    nVC3.tabBarItem.selectedImage = [UIImage imageNamed:@"liveSelected"];
    nVC4.tabBarItem.selectedImage = [UIImage imageNamed:@"liveSelected"];
/*
    nVC1.tabBarItem.badgeValue = @"1";
    nVC2.tabBarItem.badgeValue = @"2";
    nVC3.tabBarItem.badgeValue = @"3";
    nVC4.tabBarItem.badgeValue = @"4";
 */
    fVC.title  = @"一环";
    sVC.title  = @"二环";
    tVC.title  = @"三环";
    foVC.title = @"四环";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame        = CGRectMake(0, 0, 30, 30);
    imageView.image        = [UIImage imageNamed:@"love"];
    foVC.navigationItem.titleView = imageView;
    
    self.tabBar.tintColor = Tab_TinTColor;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"love"];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(5, 2, 20, 20);
//    label.text = @"6";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor redColor];
//    label.layer.cornerRadius = 10;
//    label.layer.masksToBounds = YES;
//    nVC1.tabBadgePointView = label;
//    nVC1.tabBadgePointViewOffset = UIOffsetMake(6, 4);
    
    NSArray *navArr = @[nVC1,nVC2,nVC3,nVC4];
    self.hidesBottomBarWhenPushed = YES;
    [self setViewControllers:navArr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
