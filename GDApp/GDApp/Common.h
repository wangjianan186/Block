//
//  Common.h
//  GDApp
//
//  Created by Bigbang on 16/1/18.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#ifndef Common_h
#define Common_h

//字体颜色
#define Title_Color [UIColor colorWithRed:0.36 green:0.76 blue:0.75 alpha:1]
//字体大小
#define Title_Font  [UIFont systemFontOfSize:12.0]


// 弱引用
#define GDWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define GDLog(...) NSLog(__VA_ARGS__)
#else
#define GDLog(...)
#endif

//常量定义
#define GD_StateBar_Heigh            20
#define GD_NavigationBar_Heigh       44
#define GD_TableBar_Heigh            49

#define GD_Screen_Width              ([UIScreen mainScreen].bounds.size.width)
#define GD_Screen_Height             ([UIScreen mainScreen].bounds.size.height)
#define GD_CurrentView_Width         (self.view.bounds.size.width)
#define GD_CurrentView_Height        (self.view.bounds.size.height)

// 一像素线
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

//定义保护



#endif /* Common_h */
