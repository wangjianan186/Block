//
//  UIViewController+LxTabBadgePoint.m
//  LxTabBadgePointDemo
//
//  Created by DeveloperLx on 15/11/24.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

#import "UIViewController+LxTabBadgePoint.h"
#import <objc/runtime.h>

@implementation UIViewController (LxTabBadgePoint)

#pragma mark - public method

- (void)setShowTabBadgePoint:(BOOL)showTabBadgePoint
{
    if (showTabBadgePoint && self.tabBadgePointView.superview == nil) {
        self.tabBadgePointView.center = self.tabBadgePointViewCenter;
        [self.tabBarButton addSubview:self.tabBadgePointView];
    }
    
    self.tabBadgePointView.hidden = showTabBadgePoint == NO;
}

- (BOOL)showTabBadgePoint
{
    return !self.tabBadgePointView.hidden;
}

- (void)setTabBadgePointView:(UIView *)tabBadgePointView
{
    if (tabBadgePointView.superview) {
        [tabBadgePointView removeFromSuperview];
    }
    
    tabBadgePointView.hidden = YES;
    
    objc_setAssociatedObject(self, @selector(tabBadgePointView), tabBadgePointView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)tabBadgePointView
{
    UIView * tabBadgePointView = objc_getAssociatedObject(self, @selector(tabBadgePointView));
    
    if (tabBadgePointView == nil) {
        tabBadgePointView = self.defaultTabBadgePointView;
        objc_setAssociatedObject(self, @selector(tabBadgePointView), tabBadgePointView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return tabBadgePointView;
}

- (void)setTabBadgePointViewOffset:(UIOffset)tabBadgePointViewOffset
{
    objc_setAssociatedObject(self, @selector(tabBadgePointViewOffset), [NSValue valueWithUIOffset:tabBadgePointViewOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.tabBadgePointView.center = self.tabBadgePointViewCenter;
}

- (UIOffset)tabBadgePointViewOffset
{
    id tabBadgePointViewOffsetObject = objc_getAssociatedObject(self, @selector(tabBadgePointViewOffset));
    UIOffset tabBadgePointViewOffset = [tabBadgePointViewOffsetObject UIOffsetValue];
    return tabBadgePointViewOffset;
}

- (BOOL)isEmbedInTabBarController
{
    if (self.tabBarController == nil) {
        return NO;
    }
    
    BOOL isEmbedInTabBarController = NO;

    for (NSInteger i = 0; i < self.tabBarController.viewControllers.count; i++) {
        
        UIViewController * vc = self.tabBarController.viewControllers[i];
        
        if (vc == self) {
            isEmbedInTabBarController = YES;
            self.tabIndex = i;
            break;
        }
    }
    
    return isEmbedInTabBarController;
}

- (void)setTabIndex:(NSInteger)tabIndex
{
    objc_setAssociatedObject(self, @selector(tabIndex), @(tabIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)tabIndex
{
    if (self.embedInTabBarController == NO) {
        NSLog(@"LxTabBadgePoint：This viewController not embed in tabBarController");
        return NSNotFound;
    }
    
    id tabIndexObject = objc_getAssociatedObject(self, @selector(tabIndex));
    NSInteger tabIndex = [tabIndexObject integerValue];
    return tabIndex;
}

- (UIView *)tabBarButton
{
    if (self.embedInTabBarController == NO) {
        NSLog(@"LxTabBadgePoint：This viewController not embed in tabBarController");
        return nil;
    }
    
    static NSMutableArray * tabBarButtonArray = nil;
    
    if (tabBarButtonArray == nil) {
        
        tabBarButtonArray = [[NSMutableArray alloc]init];
        
        for (id subView in self.tabBarController.tabBar.subviews) {
            
            if ([NSStringFromClass([subView class]) hasPrefix:@"UITabBarButton"]) {
                
                [tabBarButtonArray addObject:subView];
            }
        }
        
        [tabBarButtonArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            UIView * tabBarButton1 = (UIView *)obj1;
            UIView * tabBarButton2 = (UIView *)obj2;
            
            return CGRectGetMinX(tabBarButton1.frame) > CGRectGetMinX(tabBarButton2.frame);
        }];
    }

    NSInteger tabIndex = self.tabIndex;
    
    if (tabIndex >= 0 && tabIndex < tabBarButtonArray.count) {
        
        return tabBarButtonArray[tabIndex];
    }
    else {
        NSLog(@"LxTabBadgePoint：Not found corresponding tabBarButton ！！！");
        return nil;
    }
}

#pragma mark - private method (Can custom.)

- (CGPoint)tabBadgePointViewCenter
{
    UIView * tabBarButton = self.tabBarButton;
    
    CGPoint tabBadgePointViewCenter = CGPointMake(CGRectGetMidX(tabBarButton.bounds) + 14, 8.5);
    tabBadgePointViewCenter.x += self.tabBadgePointViewOffset.horizontal;
    tabBadgePointViewCenter.y += self.tabBadgePointViewOffset.vertical;
    return tabBadgePointViewCenter;
}

- (UIView *)defaultTabBadgePointView
{
    CGFloat const defaultTabBadgePointViewRadius = 4.5;
    
    CGRect defaultTabBadgePointViewFrame = (CGRect){CGPointZero, CGSizeMake(defaultTabBadgePointViewRadius * 2, defaultTabBadgePointViewRadius * 2)};
    UIView * defaultTabBadgePointView = [[UIView alloc]initWithFrame:defaultTabBadgePointViewFrame];
    defaultTabBadgePointView.backgroundColor = [UIColor redColor];
    defaultTabBadgePointView.layer.cornerRadius = defaultTabBadgePointViewRadius;
    defaultTabBadgePointView.layer.masksToBounds = YES;
    
    defaultTabBadgePointView.hidden = YES;
    
    return defaultTabBadgePointView;
}

@end
