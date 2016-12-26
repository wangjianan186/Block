//
//  CustomCell.m
//  Block
//
//  Created by Bigbang on 15/12/2.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    if (self.buttonBlock) {

        self.buttonBlock (_cellIndexPath , 0);
     }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteCell:indexPath:)]) {
        [self.delegate deleteCell:sender indexPath:_cellIndexPath];
    }
}


@end
