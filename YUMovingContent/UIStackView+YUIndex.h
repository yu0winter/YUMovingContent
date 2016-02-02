//
//  UIStackView+YUIndex.h
//  YUMovingContent
//
//  Created by nyl on 16/2/2.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStackView (YUIndex)
- (NSInteger)indexForPressBeginAtPoint:(CGPoint)point;
- (NSInteger)indexForMoveFromSourceIndex:(NSInteger)sourceIndex toPoint:(CGPoint)point;
@end
