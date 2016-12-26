//
//  Person.m
//  GDApp
//
//  Created by Bigbang on 16/1/23.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark 解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"decode...");
    if (self = [super init]) {
        self.name     =  [aDecoder decodeObjectForKey:@"name"];
        self.age      =  [aDecoder decodeIntForKey:@"age"];
        self.height   =  [aDecoder decodeFloatForKey:@"heiht"];
        self.birthday =  [aDecoder decodeObjectForKey:@"birthday"];
    } 
    return self;
}

#pragma mark 编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    NSLog(@"encode...");
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt64:_age forKey:@"age" ];
    [aCoder encodeFloat:_height forKey:@"height"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];
    
}

#pragma mark 重写描述
-(NSString *)description{
    NSDateFormatter *formater1=[[NSDateFormatter alloc]init];
    formater1.dateFormat=@"yyyy-MM-dd";
    return [NSString stringWithFormat:@"name=%@,age=%i,height=%.2f,birthday=%@",_name,_age,_height,[formater1 stringFromDate:_birthday]];
}
 

@end
