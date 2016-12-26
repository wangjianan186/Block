//
//  GDLabel.h
//  GDLabel
//
//  Created by Bigbang on 15/12/4.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GDLabelTabBlock)();
@interface GDLabel : UILabel

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy)   GDLabelTabBlock tapBlock;

@end
