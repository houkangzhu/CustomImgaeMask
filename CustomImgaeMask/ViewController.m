//
//  ViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/7/26.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meinv.jpg"]];
    imgView.frame = CGRectMake(0, 0, 240, 240*1.5);
    imgView.center = self.view.center;
    
    UIView *view = [ViewController createMaskShadow:imgView];
    
    [self.view addSubview:view];
    
}


+ (UIView *)createMaskShadow:(UIView *)view {
    [ViewController addCustomMask:view];
    
    UIView *rootView = [[UIView alloc] initWithFrame:view.bounds];
    rootView.frame = view.frame;
    view.frame = rootView.bounds;
    rootView.backgroundColor = [UIColor clearColor];
    [rootView addSubview:view];
    
    CGMutablePathRef path = createMaskPath(view.bounds, 50);
    rootView.layer.shadowOpacity = 0.8;
    rootView.layer.shadowRadius = 8.0;
    rootView.layer.shadowOffset = CGSizeMake(3, 4);
    rootView.layer.shadowColor = [UIColor blackColor].CGColor;
    rootView.layer.shadowPath = path;
    CGPathRelease(path);
    return rootView;
}


+ (void)addCustomMask:(UIView *)view {
    [view layoutIfNeeded];
    
    CGMutablePathRef path = createMaskPath(view.frame, 50.0);
    
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.frame = view.bounds;
    slayer.path = path;
    slayer.strokeColor = [UIColor greenColor].CGColor;
    slayer.fillColor = [UIColor yellowColor].CGColor;
    slayer.lineCap = kCALineCapRound;
    view.layer.mask = slayer;
    
    CGPathRelease(path);
//    CGPathRelease(path2);
}

CGMutablePathRef createMaskPath(CGRect frame, CGFloat radius) {
    
    CGFloat viewWidth = CGRectGetWidth(frame);
    CGFloat viewHeight = CGRectGetHeight(frame);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &transform, radius, 0);
    CGPathAddLineToPoint(path, &transform, viewWidth - radius, 0);
    CGPathAddArc(path, &transform, viewWidth, 0, radius, M_PI, M_PI_2, true);
    CGPathAddLineToPoint(path, &transform, viewWidth, viewHeight - radius);
    CGPathAddArc(path, &transform, viewWidth, viewHeight, radius, M_PI_2 * 3, M_PI, true);
    CGPathAddLineToPoint(path, &transform, radius, viewHeight);
    CGPathAddArc(path, &transform, 0, viewHeight, radius, M_PI * 2, M_PI_2 * 3, true);
    CGPathAddLineToPoint(path, &transform, 0, radius);
    CGPathAddArc(path, &transform, 0, 0, radius, M_PI_2, 0, true);
    
    return path;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
