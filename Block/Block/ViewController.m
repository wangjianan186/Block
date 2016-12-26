//
//  ViewController.m
//  Block
//
//  Created by Bigbang on 15/12/2.
//  Copyright © 2015年 Bigbang. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,deleteButtonDelegate>

@property (nonatomic, strong) UITableView *tabeleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__FUNCTION__);

    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    _tabeleView.delegate = self;
    _tabeleView.dataSource = self;
    [self.view addSubview:_tabeleView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        //cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellIndexPath = indexPath;
    [cell.blockButton setTitle:@"交个朋友吧" forState:UIControlStateNormal];
//    cell.buttonBlock = ^{
//        NSLog(@" click ");
//    };
    cell.delegate = self;
    cell.buttonBlock = ^(NSIndexPath *indexPath, NSInteger i) {
        NSLog(@"block - - - - (%ld)",indexPath.row);
    };
    
    return cell;
}

- (void)deleteCell:(UIButton *)sender indexPath:(NSIndexPath *)indexPath {

    NSLog(@"Delegate = = =(%ld)",indexPath.row);
}
@end
