//
//  GDUIViewController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "GDUIViewController.h"

@interface GDUIViewController ()

@end

@implementation GDUIViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UI

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

}

@end
