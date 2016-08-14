//
//  TWOViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/7/27.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "TWOViewController.h"

@interface TWOViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *rView;

@property (nonatomic, strong) CAShapeLayer *moveLayer;

@end

@implementation TWOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat imgWidth  =  60;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_1"]];
    _imageView.frame = CGRectMake(0, 0, imgWidth, imgWidth);
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
//    _rView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, imgWidth, imgWidth)];
//    [self.view addSubview:_rView];

    [self drawRootView];
    
  
    _moveLayer = [CAShapeLayer layer];
    _moveLayer.frame = CGRectMake(100, 200, 40, 40);
    CGMutablePathRef path = createMovePath(CGAffineTransformIdentity, _moveLayer.bounds);
    
    _moveLayer.path = path;
    _moveLayer.strokeColor = [UIColor blackColor].CGColor;
    _moveLayer.fillColor = [UIColor greenColor].CGColor;
    _moveLayer.lineCap = kCALineCapRound;

    [self.view.layer addSublayer:_moveLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = [self createRootPath:[UIScreen mainScreen].bounds tramsform:CGAffineTransformIdentity].CGPath;
    animation.speed = 0.2;
    animation.repeatCount = NSIntegerMax;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.calculationMode = kCAAnimationLinear;
    [_moveLayer addAnimation:animation forKey:nil];
    
    
    CABasicAnimation *proAnimation = [CABasicAnimation animationWithKeyPath:@"affineTransform"];
    proAnimation.fromValue = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
    proAnimation.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(1.0, 0.6)];
    [_moveLayer addAnimation:proAnimation forKey:nil];
    
    
//    _moveLayer.shouldRasterize
//    CoreText ct;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


CGMutablePathRef createMovePath(CGAffineTransform transform, CGRect frame) {
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, &transform, width, height/2, 20, 0, M_PI * 2, false);
    return path;
}

- (void)drawRootView {
    UIBezierPath *path = [self createRootPath:[UIScreen mainScreen].bounds tramsform:CGAffineTransformIdentity];
    
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.frame = self.view.bounds;
    slayer.path = path.CGPath;
    slayer.strokeColor = [UIColor blackColor].CGColor;
    slayer.fillColor = [UIColor clearColor].CGColor;
    slayer.lineCap = kCALineCapRound;
    slayer.lineWidth = 1.0;
    [self.view.layer addSublayer:slayer];
    
}


- (UIBezierPath *)createRootPath:(CGRect)fullFrame tramsform:(CGAffineTransform)tramsform {
    CGFloat fullWidth = CGRectGetWidth(fullFrame);
    CGFloat fullHeight = CGRectGetHeight(fullFrame);
    
    CGFloat startY = 100.0;

    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapRound;
    
    CGPoint node = CGPointMake(0, startY);
    [path moveToPoint: node];
    node.x = fullWidth * 0.1;
    [path addLineToPoint:node];
    
    node.x += 50;
    node.y += 50;
    [path addQuadCurveToPoint:node controlPoint:CGPointMake(node.x - 10, node.y - 50)];
//    [path addCurveToPoint:node controlPoint1:CGPointMake(node.x + 30, node.y - 50) controlPoint2:CGPointMake(node.x - 30, node.y - 20)];
    node.x = fullWidth * 0.4;
    node.y = fullHeight * 0.8;
    [path addLineToPoint:node];
    
    node.x += 60;
    node.y += 50;
    [path addCurveToPoint:node controlPoint1:CGPointMake(node.x - 53, node.y - 20) controlPoint2:CGPointMake(node.x - 40, node.y)];
    node.x += 50;
    node.y -= 40;
    [path addCurveToPoint:node controlPoint1:CGPointMake(node.x - 20, node.y + 40) controlPoint2:CGPointMake(node.x - 10, node.y + 40)];
    node.x += 40;
    [path addQuadCurveToPoint:node controlPoint:CGPointMake(node.x - 20, node.y - 100)];
    node.x += 40;
    node.y += 60;
    [path addCurveToPoint:node controlPoint1:CGPointMake(node.x - 30, node.y) controlPoint2:CGPointMake(node.x - 30, node.y)];
    
    node.x = fullWidth;
    node.y = fullHeight * 0.9;
    [path addLineToPoint:node];
    
    return path;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
