//
//  ViewController.m
//  ZWAnimationShake
//
//  Created by 崔先生的MacBook Pro on 2022/10/11.
//

#import "ViewController.h"
#import "ZWShakeView.h"
#import <AudioToolbox/AudioToolbox.h>

#define kwidth [UIScreen mainScreen].bounds.size.width
#define kheight [UIScreen mainScreen].bounds.size.height
#define ktopHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface ViewController ()

@property (nonatomic, strong) ZWShakeView *shakeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;//防止navigationBar遮住摇一摇的视图
//    [_shakeView removeFromSuperview];
}

- (void)addShakeView {
    if (_shakeView.isShow) {
        return;
    } else {
        _shakeView = [[ZWShakeView alloc] initWithFrame:CGRectMake(15, ktopHeight, kwidth - 30, 80)];
        _shakeView.backgroundColor = [UIColor whiteColor];
        _shakeView.layer.cornerRadius = 10;
        self.shakeView.isShow = YES;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration = 0.5;
        animation.repeatCount = 1;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(kwidth / 2, -40)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(kwidth / 2, ktopHeight + 40)];
        [_shakeView.layer addAnimation:animation forKey:@"moveIn"];
        
        [self.view addSubview:_shakeView];
    }
}

- (void)moveShakeView {
    [UIView animateWithDuration:0.5 animations:^{
        self.shakeView.frame = CGRectMake(15, -80, kwidth - 30, 80);
    } completion:^(BOOL finished) {
        [self.shakeView removeFromSuperview];
        self.shakeView.isShow = NO;
    }];
}

//检测到开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    [self addShakeView];
}

//摇一摇被取消或中断
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"摇一摇被取消或中断");
    [self moveShakeView];
}

//摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//默认震动效果
//    普通短震，3D Touch 中 Pop 震动反馈
//    AudioServicesPlaySystemSound(1520);
//    普通短震，3D Touch 中 Peek 震动反馈
//    AudioServicesPlaySystemSound(1519);
    AudioServicesPlaySystemSound(1521);
    NSLog(@"摇动结束");
    
    /*采用延时执行而不使用以下的方式,因为加上动画后会导致按钮无法点击,所以在一定时间后再加上动画
     [UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionCurveEaseOut animations:^{
             self.shakeView.frame = CGRectMake(15, -80, kwidth - 30, 80);
         } completion:^(BOOL finished) {
             [self.shakeView removeFromSuperview];
         }];
     */
    [self performSelector:@selector(moveShakeView) withObject:nil afterDelay:3];
}


@end
