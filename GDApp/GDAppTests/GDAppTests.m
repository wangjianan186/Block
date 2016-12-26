//
//  GDAppTests.m
//  GDAppTests
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GDAppTests : XCTestCase

@end

@implementation GDAppTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    /*
     Logic Tests与Application Tests的区别主要在setUp方法，Logic Tests只需在setUp方法中初始化一些测试数据，
     而Application Tests需要在setUp方法中获取主应用的AppDelegate，供test方法调用。
     */
    
    //每个test方法执行前调用
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    //每个test方法执行后调用

    [super tearDown];

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //命名为XXX的测试方法

    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
