//
//  ForViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/7/28.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "ForViewController.h"
@interface ForViewController () {
    NSTimer *_timer;
}

@property (nonatomic, strong) CAShapeLayer *layer1;
@property (nonatomic, strong) CAShapeLayer *layer2;

@end

@implementation ForViewController

- (IBAction)updateAction:(id)sender {
    [self waveLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self waveLayer];
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (CAShapeLayer *)layer1 {
    if (!_layer1) {
         _layer1 = [CAShapeLayer layer];
        [_layer1 addAnimation:[self layerAnimation] forKey:nil];
    }
    return _layer1;
}

- (CAShapeLayer *)layer2 {
    if (!_layer2) {
        _layer2 = [CAShapeLayer layer];
        [_layer2 addAnimation:[self layerAnimation] forKey:nil];
    }
    return _layer2;
}

- (CAAnimation *)layerAnimation {
    CAPropertyAnimation *ani = [CAPropertyAnimation animationWithKeyPath:@"self"];
    return ani;
}

- (void)waveLayer {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = screenWidth/8*7;
    CGFloat cellLeft = screenWidth/8;
    NSInteger baseWidth = screenWidth/6;
    CGFloat cellWidth = arc4random()%baseWidth;
    
    CGFloat y = 150;
    
    CGRect showFrame = CGRectMake(0, screenWidth, screenWidth, y*2);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for (; cellLeft < maxWidth; cellLeft += cellWidth) {
        float h = (arc4random()%10 + 3)/10.0;
        cellWidth = arc4random()%baseWidth;
        CGMutablePathRef cgpath = creatWaveCell(cellLeft, cellWidth, y, CGPointMake(0.5, h));
        CGPathAddPath(path, NULL, cgpath);
        CGPathRelease(cgpath);
    }
    [self.layer1 removeFromSuperlayer];
    self.layer1.frame = showFrame;
    self.layer1.path = path;
    UIColor *color = [self randomColor];
    self.layer1.fillColor = color.CGColor;
    self.layer1.strokeColor = [UIColor clearColor].CGColor;
    self.layer1.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:self.layer1];
    CGPathRelease(path);
    
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    for (; cellLeft < maxWidth; cellLeft += cellWidth) {
        float h = (arc4random()%10 + 3)/10.0;
        cellWidth = arc4random()%baseWidth;
        CGMutablePathRef cgpath = creatWaveCell(cellLeft, cellWidth, y, CGPointMake(0.5, h));
        CGPathAddPath(path2, NULL, cgpath);
        CGPathRelease(cgpath);
    }
    [self.layer2 removeFromSuperlayer];
    self.layer2.frame = showFrame;
    self.layer2.path = path2;
    UIColor *color2 = [self randomColor];
    self.layer2.fillColor = color2.CGColor;
    self.layer2.strokeColor = [UIColor clearColor].CGColor;
    self.layer2.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:self.layer2];
    CGPathRelease(path2);
}

CGMutablePathRef creatWaveCell(CGFloat leftX, CGFloat width, CGFloat leftY, CGPoint control) {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(leftX, leftY);
    CGFloat ctrlX = width*control.x;
    CGFloat ctrlY = width*control.y;
    CGMutablePathRef cgpath = CGPathCreateMutable();
    CGPathMoveToPoint(cgpath, &transform, 0, 0);
    CGPathAddQuadCurveToPoint(cgpath, &transform, ctrlX, -ctrlY, width, 0);
    CGPathMoveToPoint(cgpath, &transform, 0, 0);
    CGPathAddQuadCurveToPoint(cgpath, &transform, ctrlX, ctrlY, width, 0);
    return cgpath;
}


- (NSArray *)colors {
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:6];
    for (int i=0; i<6; i++) {
        [colors addObject:[self randomColor]];
    }
    return colors;
}

- (UIColor *)randomColor {
    float color_r = arc4random()%256/255.0;
    float color_g = arc4random()%256/255.0;
    float color_b = arc4random()%256/255.0;
    float color_a = arc4random()%10/10.0 + 0.3;
    UIColor *color = [UIColor colorWithRed:color_r green:color_g blue:color_b alpha:color_a>1.0?1.0:color_a];
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
 //
 //    CMSampleBufferRef buff;
 //
 //    CVImageBufferRef imgBuffer = CMSampleBufferGetImageBuffer(buff);
 //    CVPixelBufferRef pixBuffer = imgBuffer;
 //    CVPixelBufferLockBaseAddress(pixBuffer, kCVPixelBufferLock_ReadOnly);
 //
 ////    CMBufferQueueEnqueue(<#CMBufferQueueRef  _Nonnull queue#>, <#CMBufferRef  _Nonnull buf#>)
 //
 //    CMTime time = CMTimeMake(1, 10);
 //
 ////    CMBufferRef buff = CMBufferQueueDequeueAndRetain(NULL);
 //
 //    CVPixelBufferUnlockBaseAddress(pixBuffer, kCVPixelBufferLock_ReadOnly);
 //
 //    size_t len = CVPixelBufferGetDataSize(pixBuffer);
 //
 //    void * adress = CVPixelBufferGetBaseAddress(pixBuffer);
 //        UIBezierPath
 */
@end
