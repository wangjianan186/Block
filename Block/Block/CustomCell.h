//
//  CustomCell.h
//  Block
//
//  Created by Bigbang on 15/12/2.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(NSIndexPath *indexPath, NSInteger integer);

@protocol deleteButtonDelegate <NSObject>

@optional

- (void)deleteCell:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

@end

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (nonatomic, copy) ButtonBlock buttonBlock;
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, weak) id<deleteButtonDelegate> delegate;


@end
