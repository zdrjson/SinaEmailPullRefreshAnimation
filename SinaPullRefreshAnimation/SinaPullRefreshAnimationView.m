//
//  SinaPullRefreshAnimationView.m
//  SinaPullRefreshAnimation
//
//  Created by 张德荣 on 16/7/10.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "SinaPullRefreshAnimationView.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface SinaPullRefreshAnimationView ()


@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, assign) BOOL stop;

@end

@implementation SinaPullRefreshAnimationView


static CGFloat wh = 15.0f;
static CGFloat offSet = 25.0f;
static CGFloat viewalpha = 0.5f;
static CGFloat animationTime = 0.3f;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.leftView];
        
        
        //middle yellow
        [self addSubview:self.middleView];
        
        
        
        //right green
        [self addSubview:self.rightView];
    }
    return self;
}
+ (instancetype)sharedInstance
{
    static SinaPullRefreshAnimationView* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SinaPullRefreshAnimationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                if (window != nil) {
        
            [window addSubview:instance];
            
        }
    });

    return instance;
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor redColor];
        _leftView.frame = CGRectMake(CGRectGetMinX(self.middleView.frame) - offSet, kScreenHeight * 0.5, wh, wh);
        _leftView.alpha = viewalpha;
        _leftView.layer.cornerRadius = wh * 0.5;
    }
    return _leftView;
}
- (UIView *)middleView
{
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor yellowColor];
        _middleView.frame = CGRectMake(kScreenWidth * 0.5 - wh * 0.5, kScreenHeight * 0.5, wh, wh);
        _middleView.layer.cornerRadius = wh * 0.5;
        _middleView.alpha = viewalpha;
        
        
    }
    return _middleView;
}
- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor greenColor];
        _rightView.frame = CGRectMake(CGRectGetMinX(self.middleView.frame) + offSet, kScreenHeight * 0.5, wh, wh);
        _rightView.layer.cornerRadius = wh * 0.5;
        _rightView.alpha = viewalpha;
    }
    return _rightView;
}

+ (void)startAnimation {
    SinaPullRefreshAnimationView *sinaPullRefreshAnimationView = [SinaPullRefreshAnimationView sharedInstance];
 
    [sinaPullRefreshAnimationView animation];
}

+ (void)stopAnimation {
	 SinaPullRefreshAnimationView *sinaPullRefreshAnimationView = [SinaPullRefreshAnimationView sharedInstance];
   sinaPullRefreshAnimationView.stop = YES;
}

- (void)animation {
    
    UIView *leftView = (UIView *)self.subviews.firstObject;
    
    UIView *middleView = (UIView *)self.subviews[1];
    
    UIView *rightView = (UIView *)self.subviews[2];
    
    [UIView animateWithDuration:animationTime * 2 animations:^{
        
        leftView.frame = CGRectMake(leftView.frame.origin.x + 2 * offSet, leftView.frame.origin.y, wh, wh);
    }];
    
    [UIView animateWithDuration:animationTime animations:^{
    
          rightView.frame = CGRectMake(rightView.frame.origin.x - offSet, rightView.frame.origin.y, wh, wh);
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationTime animations:^{
            
            
            middleView.frame = CGRectMake(middleView.frame.origin.x - offSet, middleView.frame.origin.y, wh, wh);

            
        } completion:^(BOOL finished) {

            
            CGFloat min =  MIN(leftView.frame.origin.x, middleView.frame.origin.x);
            CGFloat min1 = MIN(min, rightView.frame.origin.x);
            
            CGFloat max =  MAX(leftView.frame.origin.x, middleView.frame.origin.x);
            CGFloat max1 = MAX(max, rightView.frame.origin.x);
            
            if (leftView.frame.origin.x == min1) {
                [self insertSubview:leftView atIndex:0];
            }
            else if (middleView.frame.origin.x == min1) {
                [self insertSubview:middleView atIndex:0];
            }
            else if (rightView.frame.origin.x == min1) {
                [self insertSubview:rightView atIndex:0];
            }
            
            
            if (leftView.frame.origin.x == max1) {
                [self insertSubview:leftView atIndex:2];
            }
            else if (middleView.frame.origin.x == max1) {
                [self insertSubview:middleView atIndex:2];
            }
            else if (rightView.frame.origin.x == max1) {
                [self insertSubview:rightView atIndex:2];
            }
            
            //recurrence
            if (!self.stop) {
                [self animation];
            }
         

    
        }];
    });
}

@end
