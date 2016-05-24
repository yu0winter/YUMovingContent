//
//  YUMovingContentOCUITests.m
//  YUMovingContentOCUITests
//
//  Created by 牛玉龙 on 16/3/30.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface YUMovingContentOCUITests : XCTestCase

@end

@implementation YUMovingContentOCUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    XCUIElementQuery *scrollViewsQuery = [[XCUIApplication alloc] init].scrollViews;
    [scrollViewsQuery.otherElements.staticTexts[@"\u7334\u5e74\u5927\u5409\uff01  Happy new Year! 10"] pressForDuration:2.2];

    XCUIElement *image = [[scrollViewsQuery childrenMatchingType:XCUIElementTypeImage] elementBoundByIndex:1];
    [image swipeDown];
    [image swipeUp];
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
