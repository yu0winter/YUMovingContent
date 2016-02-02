//
//  UIView+YUSnapshot.h
//  YUMovingContent
//
//  Created by nyl on 16/2/2.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YUSnapshot)
/** Returns a customized snapshot of a given view. */
+ (UIView *)customSnapshoFromView:(UIView *)inputView;
@end
