//
//  ViewController.m
//  SinaPullRefreshAnimation
//
//  Created by 张德荣 on 16/7/10.
//  Copyright © 2016年 zdrjson. All rights reserved.
//

#import "ViewController.h"

#import "SinaPullRefreshAnimationView.h"
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *leftView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    
//   first
    //left 向右移动 offSet
    //right 向左移动 offSet
    
//    second
   //left 向右移动 offSet
   //middle 向左移动 offSet
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
      [SinaPullRefreshAnimationView startAnimation];

    
   
}


@end
