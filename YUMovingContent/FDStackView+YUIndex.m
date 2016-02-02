//
//  FDStackView+YUIndex.m
//  YUMovingContent
//
//  Created by nyl on 16/2/2.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import "FDStackView+YUIndex.h"

@implementation FDStackView (YUIndex)
- (NSInteger)indexForMoveFromSourceIndex:(NSInteger)sourceIndex toPoint:(CGPoint)point{
    NSInteger index = sourceIndex;
    if (sourceIndex > 0) {
        UIView * lastView = self.arrangedSubviews[sourceIndex-1];
        if (point.y < lastView.center.y) {
            index = [self.arrangedSubviews indexOfObject:lastView];
        }
    }
    if (sourceIndex < self.arrangedSubviews.count-1) {
        UIView * nextView = self.arrangedSubviews[sourceIndex+1];
        if (point.y > nextView.center.y) {
            index = [self.arrangedSubviews indexOfObject:nextView];
        }
    }
    if (index >= self.arrangedSubviews.count) {
        index = self.arrangedSubviews.count -1;
    }
    return index;
}

- (NSInteger)indexForPressBeginAtPoint:(CGPoint)point{
    NSInteger index;
    for (UIView *view in self.arrangedSubviews) {
        CGFloat minY = view.frame.origin.y;
        CGFloat maxY = view.frame.origin.y + view.frame.size.height + self.spacing;
        if(point.y > minY && point.y < maxY){
            index = [self.arrangedSubviews indexOfObject:view];
            return index;
        }
    }
    return index;
}

@end
