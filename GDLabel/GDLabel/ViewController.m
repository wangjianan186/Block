//
//  ViewController.m
//  GDLabel
//
//  Created by Bigbang on 15/12/4.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import "ViewController.h"
#import "GDLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    GDLabel *label = [[GDLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
    label.backgroundColor = [UIColor greenColor];
    label.tapBlock = ^{
        NSLog(@"wahahah");
    };
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
