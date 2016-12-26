//
//  FirstViewController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "FirstViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+LxTabBadgePoint.h"

#define TipLabel_X      0
#define TipLabel_Heigh  30

@interface FirstViewController () <UITableViewDataSource,UITableViewDelegate>{
    
    UITableView      *_mainTableView;
    UIRefreshControl *_freshControl;
    NSMutableArray   *_dataArray;
}

@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation FirstViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        GDLog(@"%s",__FUNCTION__);
        //@()  NSNumber
        //@[]  NSArray
        //@{}  NSDictionary
        //NSClassFromString(@"雷明");
        //在编译时是NSString类型,运行时是NSData类型
        //NSString *obj = [[NSData alloc] init];
        
        // WKWebView  适配 iOS 8之后
        //webkit使用WKWebView来代替IOS的UIWebView和OSX的WebView，并且使用 Nitro JavaScript 引擎，这意味着所有第三方浏览器运行JavaScript将会跟safari一样快。
    }
    return self;
}

- (void)loadView {
    [super loadView];
    GDLog(@"%s",__FUNCTION__);
    //self.navigationController.showTabBadgePoint = YES;
    @try {
        //执行的代码，其中可能有异常。一旦发现异常，则立即跳到catch执行。否则不会执行catch里面的内容
    }
    @catch (NSException *exception) {
        //除非try里面执行代码发生了异常，否则这里的代码不会执行
    }
    @finally {
        //不管什么情况都会执行，包括try catch 里面用了return ,可以理解为只要执行了try或者catch，就一定会执行 finally
    }
    
    /**
     *  抛出异常
     */
//    NSException *e = [NSException
//                      exceptionWithName: @"BoxOverflowException"
//                      reason: @"The level is above 100"
//                      userInfo: nil];
//    @throw e;
}

- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self someObjectInit];
    //[self setupUI];
    
    [self setupWKWebView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
}

- (void)viewDidDisAppear:(BOOL)animated {
    [super viewDidDisappear:animated];

    
}

- (void)dealloc {
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
 
    
}

#pragma mark - UI

- (void)setupWKWebView {

    
}

- (void)setupUI {
  
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GD_Screen_Width, GD_Screen_Height - GD_StateBar_Heigh - GD_NavigationBar_Heigh - GD_TableBar_Heigh) style:UITableViewStylePlain];
    _mainTableView.delegate   = self;
    _mainTableView.dataSource = self;
    //_mainTableView.tableHeaderView = _freshControl;
    [self.view addSubview:_mainTableView];
    
    _freshControl = [[UIRefreshControl alloc] init];
    _freshControl.tintColor = Title_Color;
    [_freshControl addTarget:self action:@selector(refreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [_mainTableView addSubview:_freshControl];
}

- (void)someObjectInit {
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2", nil];
}

#pragma mark - TableViewDelegate 

//这个方法对于cell定高的UITableView来说没有意义，但如果由于某些原因需要动态高度的cell的话，这个方法可以很容易地让滑动更流畅
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= GD_Screen_Height/2) {
        NSArray *array = @[@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2"];
        NSLog(@"加数据");
        [_dataArray addObjectsFromArray:array];
        [_mainTableView reloadData];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y == 0) {
    }
}

#pragma mark - prorerty getter 

- (UILabel *)tipLabel {

    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.frame = CGRectMake(TipLabel_X, -TipLabel_Heigh, GD_Screen_Width, TipLabel_Heigh);
        _tipLabel.text = @"已更新\n";
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = Title_Font;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.backgroundColor = Title_Color;
     }
    return _tipLabel;
}

#pragma mark - @Selector

- (void)refreshViewControlEventValueChanged {
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0f];
}

- (void)loadData {
    // 生成随机数，并加入marray数组中
    unsigned int randomNumber = arc4random() % 10;
    NSString *randomData = [NSString stringWithFormat:@"%i", randomNumber];
    [_dataArray addObject:randomData];
    // 刷新表格
    [_mainTableView reloadData];
    [_freshControl endRefreshing];
    [self showTipLabel];

}

- (void)showTipLabel {
    [self.view addSubview:self.tipLabel];
    [UIView animateWithDuration:0.75 animations:^{
        self.tipLabel.frame = CGRectMake(TipLabel_X, 0, GD_Screen_Width, TipLabel_Heigh);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(tipLabelHidden) withObject:nil afterDelay:1.0];
    }];
}

- (void)tipLabelHidden {
    [UIView animateWithDuration:0.75 animations:^{
        self.tipLabel.frame = CGRectMake(TipLabel_X, -TipLabel_Heigh, GD_Screen_Width, TipLabel_Heigh);
    } completion:^(BOOL finished) {
        [self.tipLabel removeFromSuperview];
    }];
}

@end
