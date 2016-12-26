//
//  Person.h
//  GDApp
//
//  Created by Bigbang on 16/1/23.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
///姓名
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) NSDate *birthday;

@end
