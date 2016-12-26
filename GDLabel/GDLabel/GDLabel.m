//
//  GDLabel.m
//  GDLabel
//
//  Created by Bigbang on 15/12/4.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import "GDLabel.h"

@implementation GDLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

    self.userInteractionEnabled = YES;
    self.enable = YES;
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tab];
}

- (void)onTap:(UITapGestureRecognizer *)tap {

    if (!self.enable) return;
    if (self.tapBlock) {
        self.tapBlock();
    }

}

@end
