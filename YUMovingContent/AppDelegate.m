//
//  AppDelegate.m
//  YUMovingContent
//
//  Created by nyl on 16/2/2.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import "AppDelegate.h"
#import "YUViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    YUViewController *rootVC = [[YUViewController alloc] init];
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    return YES;
}

@end