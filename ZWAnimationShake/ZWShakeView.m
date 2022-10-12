//
//  ZWShakeView.m
//  ZWAnimationShake
//
//  Created by 崔先生的MacBook Pro on 2022/10/11.
//

#import "ZWShakeView.h"
#import "SecondViewController.h"

@interface ZWShakeView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ZWShakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addWidgets];
    }
    return self;
}

- (void)addWidgets {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    imageView.image = [UIImage imageNamed:@"shakeImage"];
    [self addSubview:imageView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 150, 20)];
//    [topLabel setText:@"123"];
    topLabel.text = @"面对面摇一摇";
    [topLabel setTextColor:[UIColor blackColor]];
    [topLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [self addSubview:topLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 150, 20)];
    bottomLabel.text = @"聚会玩骰子、加朋友";
    [bottomLabel setTextColor:[UIColor blackColor]];
    [bottomLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:bottomLabel];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 20, 40, 40)];
    [_btn setTitle:@"进入" forState:UIControlStateNormal];
    [_btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

- (void)btnClick {
    SecondViewController *vc = [SecondViewController new];
    [[self getNavigationController] pushViewController:vc animated:YES];
}

/// 获取Nav
- (UINavigationController *)getNavigationController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)window.rootViewController;
    } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [((UITabBarController *)window.rootViewController)selectedViewController];
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)selectedVC;
        }
    }
    return nil;
}

@end
