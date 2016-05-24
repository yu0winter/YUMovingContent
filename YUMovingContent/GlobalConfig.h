//
//  GlobalConfig.h
//  YUMovingContent
//
//  Created by nyl on 16/2/2.
//  Copyright © 2016年 nyl. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h
//屏幕宽度
#define SCREEN_WIDTH (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? [[UIScreen mainScreen] bounds].size.width : 1024)
//屏幕高度
#define SCREEN_HEIGHT (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? ([[UIScreen mainScreen] bounds].size.height) : 748)

#define IS_OS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
//状态栏高度
#define STATUSBAR_HEIGHT (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? 19 : 0)
//导航栏高度
#define NAVIGATION_BAR_HEIGHT 44
//底部控制栏高度
#define TAB_BAR_HEIGHT 49



#endif
/* GlobalConfig_h */
