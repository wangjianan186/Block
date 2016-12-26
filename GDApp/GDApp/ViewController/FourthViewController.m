//
//  FourthViewController.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "FourthViewController.h"
#import "Person.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"1");
    }
    return self;
}

- (void)loadView {
    [super loadView];
    NSLog(@"2");
    
}

- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];
    NSLog(@"3");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"4");
    [self fileManager];
    [self archiver];
    [self objectArchiver];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"5");
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"6");
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"7");
    
}

- (void)viewDidDisAppear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"8");
    
}

- (void)dealloc {
    NSLog(@"9");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"10");
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"11");
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"12");
    
    
}

#pragma mark - NSFileManage

/*目录操作*/
- (void)fileManager {
    //文件管理器是专门用于文件管理的类
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获得当前程序所在目录(当然可以改变)
    //NSString *currentPath = [fileManager currentDirectoryPath];
    NSString *myPath = @"/Users/Bigbang/Desktop/怯";
    NSError *error = nil;
    BOOL result = [fileManager createDirectoryAtPath:myPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (result == NO) {
        GDLog(@"创建失败");
    }
    [self performSelector:@selector(creatFile) withObject:nil afterDelay:6.0];
}

/*文件操作*/
- (void)creatFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath=@"/Users/Bigbang/Desktop/怯/Bigbang.txt";
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"已存在");
    } else {
        NSString *contents = [NSString stringWithFormat:@"下雪了"];
        NSData *data = [contents dataUsingEncoding:NSUTF8StringEncoding];
        [fileManager createFileAtPath:filePath contents:data attributes:nil];
    }
    
    [self performSelector:@selector(deleteFile) withObject:nil afterDelay:6.0];
}

- (void)deleteFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath=@"/Users/Bigbang/Desktop/怯/Bigbang.txt";
    [fileManager removeItemAtPath:filePath error:nil];
}

/*归档操作*/
/*
如果要对自定义对象进行归档那么这个对象必须实现NSCoding协议，在这个协议中有两个方法都必须实现：

-(void)encodeWithCoder:(NSCoder *)aCoder;通过给定的Archiver对消息接收者进行编码；

-(id)initWithCoder:(NSCoder *)aDecoder;从一个给定的Unarchiver的数据返回一个初始化对象；
*/

- (void)archiver {
    
    NSString *path1=@"/Users/Bigbang/Desktop/怯/T-ara.arc";
    
    int          int1     = 89;
    CGSize       size1    = {12.5,16.8};
    NSNumber     *number1 = @60.5;
    NSString     *str1    = @"Hello,world!";
    NSArray      *array1  = @[@"Kenshin",@"Kaoru",@"Rosa"];
    NSDictionary *dic1    = @{@"name":@"Kenshin",@"age":@28,@"height":@172.5};
    
    //同时对多个对象进行归档
    NSMutableData *data1 = [[NSMutableData alloc]init];//定义一个NSMutableData用于临时存放数据
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data1];//定义归档对象
    [archiver encodeInt:int1 forKey:@"int"];//对int1归档并指定一个key以便以后读取
    [archiver encodeCGSize:size1 forKey:@"size"];
    [archiver encodeObject:number1 forKey:@"number"];
    [archiver encodeObject:str1 forKey:@"string"];
    [archiver encodeObject:array1 forKey:@"array"];
    [archiver encodeObject:dic1 forKey:@"dic"];
    
    [archiver finishEncoding];//结束归档
    [data1 writeToFile:path1 atomically:YES];//写入文件


}

- (void)unarchiver {
    NSString *path1=@"/Users/Bigbang/Desktop/怯/T-ara.arc";
    /*解档*/
    int int2;
    CGSize size2;
    NSNumber *number2;
    NSString *str2;
    NSArray *array2;
    NSDictionary *dic2;
    
    NSData *data2=[[NSData alloc]initWithContentsOfFile:path1];//读出数据到NSData
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
    
    int2= [unarchiver decodeIntForKey:@"int"];
    size2=[unarchiver decodeCGSizeForKey:@"size"];
    number2=[unarchiver decodeObjectForKey:@"number"];
    str2=[unarchiver decodeObjectForKey:@"string"];
    array2=[unarchiver decodeObjectForKey:@"array"];
    dic2=[unarchiver decodeObjectForKey:@"dic"];
    
    [unarchiver finishDecoding];
    NSLog(@"int2=%i,size=%@,number2=%@,str2=%@,array2=%@,dic2=%@",int2,NSStringFromCGSize(size2),number2,str2,array2,dic2);
}

- (void)objectArchiver {
    //归档
    Person *person1=[[Person alloc]init];
    person1.name=@"Kenshin";
    person1.age=28;
    person1.height=1.72;
    NSDateFormatter *formater1=[[NSDateFormatter alloc]init];
    formater1.dateFormat=@"yyyy-MM-dd";
    person1.birthday=[formater1 dateFromString:@"1986-08-08"];
    
    NSString *path1=@"/Users/Bigbang/Desktop/怯/KARA.arc";
    
    [NSKeyedArchiver archiveRootObject:person1 toFile:path1];
    
    //解档
    Person *person2= [NSKeyedUnarchiver unarchiveObjectWithFile:path1];
    NSLog(@"%@",person2);
    /*结果：
     name=Kenshin,age=28,height=0.00,birthday=1986-08-08
     */
    
}

- (void)sandBox {
        //沙盒根目录
        NSString *directory = NSHomeDirectory();
        NSLog(@"directory:%@", directory);
    
    
        //获取Documents路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSLog(@"path:%@", path);
    
    
        //获取Library路径
        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path1 = [paths1 objectAtIndex:0];
        NSLog(@"path：%@", path1);
    
        //获取Caches路径
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path2 = [paths2 objectAtIndex:0];
        NSLog(@"path：%@", path2);
    
    
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"tmp：%@", tmp);
}

@end
