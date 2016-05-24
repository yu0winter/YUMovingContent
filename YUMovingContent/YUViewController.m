//
//  YUViewController.m
//  YUMovingContent
//
//  Created by nyl on 16/2/1.
//  Copyright © 2016年 nyl. All rights reserved.
//

#import "YUViewController.h"
#import <Masonry.h>
#import "UIStackView+YUIndex.h"
#import "FDStackView+YUIndex.m"
#import "UIView+YUSnapshot.h"

@interface YUViewController()
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) NSTimer *scrollTopTimer;
@property (nonatomic, strong) NSTimer *scrollDownTimer;

@end
@implementation YUViewController
#pragma mark - LifeCycle 生命周期
- (void)dealloc{
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self addSubViews];
    [self layoutPageSubViews];
    [self testWithDemoViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)addSubViews{
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.stackView];
    
    self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    self.stackView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
}
- (void)layoutPageSubViews{

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(20);
        make.left.equalTo(self.containerView).offset(20);
        make.width.equalTo(self.containerView).offset(-40);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.stackView.mas_bottom).offset(20);
    }];
}
- (void)testWithDemoViews{
    for (int i = 0; i<16; i++) {
        if (i%3==0) {
            UITextView *textView = [[UITextView alloc] init];
            textView.textColor = [UIColor blackColor];
            textView.font = [UIFont systemFontOfSize:17];
            textView.text = [NSString stringWithFormat:@"\n    I am a textView ********** %d\n",i+1];
            textView.backgroundColor =  [UIColor colorWithWhite:0.8 alpha:1];
            textView.scrollEnabled = NO;
            [self.stackView addArrangedSubview:textView];
        }
        else if(i%3 == 1){
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"\n    I am a label ********** %d\n",i+1];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
            [self.stackView addArrangedSubview:label];
        }
        else{
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"wd_fw"];
            [self.stackView addArrangedSubview:imageView];
        }
    }
}
#pragma mark - Protocol Conformance 遵循协议
#pragma mark - Delegate Realization 实现委ta托方法
#pragma mark - OverWrite SuperClass Method 重写父类方法
#pragma mark - Custom Accessors 自定义属性
#pragma mark Views
- (UIScrollView *)containerView{
    if (_containerView) return _containerView;
    UIScrollView *containerView = [[UIScrollView alloc] init];
    containerView.scrollEnabled = YES;
    _containerView = containerView;
    return _containerView;
}
- (UIStackView *)stackView{
    if (_stackView) return _stackView;
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 10.f;
    [stackView addGestureRecognizer:self.longPress];
    _stackView = stackView;
    return _stackView;
}
- (UILongPressGestureRecognizer *)longPress{
    if (_longPress) return _longPress;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    longPress.minimumPressDuration = 0.4;
    _longPress = longPress;
    return _longPress;
}
#pragma mark - Custom Method    自定义方法
#pragma mark LongPress and Scroll
- (void)longPressGestureRecognized:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint locactionInView = [longPress locationInView:self.view];
    CGPoint locactionInContainView = [longPress locationInView:self.containerView];
    CGPoint location = [longPress locationInView:self.stackView];
    
    static UIView       *sourceView = nil;
    static UIView       *snapshot = nil;         ///< A snapshot of the row user is moving.
    static NSInteger    sourceIndex = -1;        ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            sourceIndex = [self.stackView indexForPressBeginAtPoint:location];
            if (sourceIndex >= 0) {
                NSLog(@"UIGestureRecognizerStateBegan");
                sourceView = [self.stackView.arrangedSubviews objectAtIndex:sourceIndex];
                // Take a snapshot of the selected row using helper method.
                snapshot = [UIView customSnapshoFromView:sourceView];
                snapshot.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
                // Add the snapshot as subview, centered at cell's center...
                [self.containerView addSubview:snapshot];
                snapshot.center = locactionInContainView;
                [UIView animateWithDuration:0.25 animations:^{
                    CGFloat scale = 0.5;
                    CGFloat maxHeight = SCREEN_WIDTH - 40;
                    if (sourceView.frame.size.height>maxHeight) {
                        scale = maxHeight/sourceView.frame.size.height;
                    }
                    snapshot.transform = CGAffineTransformMakeScale(scale,scale);
                    snapshot.alpha = 0.98;
                    // ... hide the row.
                    sourceView.alpha = 0.0;
                } completion:^(BOOL finished) {
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            snapshot.center = locactionInContainView;
            NSInteger index = [self.stackView indexForMoveFromSourceIndex:sourceIndex toPoint:location];
            NSLog(@"destIndex :%ld ,sourceIndex:%ld",(long)index,(long)sourceIndex);
            if (index != sourceIndex) {
                if (IS_OS_9_OR_LATER) {
                    //UIStackView
                    [self.stackView insertArrangedSubview:sourceView atIndex:index];
                }
                else{
                    //FDStackViewx
                    [self.stackView removeArrangedSubview:sourceView];
                    [self.stackView insertArrangedSubview:sourceView atIndex:index];
                }
                sourceIndex = index;
            }
            //拖动Scroll 上下移动
            if (locactionInView.y - (NAVIGATION_BAR_HEIGHT + STATUSBAR_HEIGHT) <100 && location.y > 100) {
                if (self.scrollTopTimer == nil) {
                    [self invaildateTimer];
                    self.scrollTopTimer = [NSTimer timerWithTimeInterval:0.02f target:self selector:@selector(scrollTop:) userInfo:snapshot repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.scrollTopTimer forMode:NSRunLoopCommonModes];
                }
            }else if(self.view.frame.size.height - locactionInView.y < 100 && self.stackView.frame.size.height - location.y >100 ){
                if (self.scrollDownTimer == nil) {
                    [self invaildateTimer];
                    self.scrollDownTimer = [NSTimer timerWithTimeInterval:0.02f target:self selector:@selector(scrollDown:) userInfo:snapshot repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.scrollDownTimer forMode:NSRunLoopCommonModes];
                }
            }
            else {
                [self invaildateTimer];
            }
            break;
        }
        default: {
            NSLog(@"UIGestureRecognizerState Else");
            // Clean up.
            UIView *cell = sourceView;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndex = -1;
                [snapshot removeFromSuperview];
                snapshot = nil;
            }];
            [self invaildateTimer];
            break;
        }
    }
}

- (void)scrollTop:(NSTimer *)timer{
    NSLog(@"向上移动...");
    [self scrollStackViewWithDistance:-5 snapShotView:timer.userInfo];
}
- (void)scrollDown:(NSTimer *)timer{
    NSLog(@"向下移动...");
    [self scrollStackViewWithDistance:5 snapShotView:timer.userInfo];
}
- (void)scrollStackViewWithDistance:(CGFloat)distance snapShotView:(UIView *)snapshot{
    CGPoint contentOffset = self.containerView.contentOffset;
    contentOffset.y += distance;
    if (snapshot) {
        CGPoint center = snapshot.center;
        center.y +=distance;
        snapshot.center = center;
    }
    self.containerView.contentOffset = contentOffset;
}
- (void)invaildateTimer{
    if (self.scrollTopTimer) {
        NSLog(@"消除 scrollTopTimer 定时器");
        [self.scrollTopTimer invalidate];
        self.scrollTopTimer = nil;
    }
    if(self.scrollDownTimer){
        NSLog(@"消除 scrollDownTimer 定时器");
        [self.scrollDownTimer invalidate];
        self.scrollDownTimer = nil;
    }
}

@end
