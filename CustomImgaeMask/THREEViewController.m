//
//  THREEViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/7/28.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "THREEViewController.h"

@interface THREEViewController ()

@end

@implementation THREEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 240, 320)];
    img.image = [[self class] imageWithSize:img.bounds.size customDraw:^(CGContextRef context) {
        [[UIColor greenColor] setFill];
        [[UIColor blackColor] setStroke];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 200, 240) cornerRadius:50.0];
        path.lineWidth = 2.0;
        [path stroke];
        
        [@"你好你好..." drawInRect:img.bounds withAttributes:@{
                                                           NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                           NSStrokeColorAttributeName:[UIColor redColor]
                                                           }];
        
//        [path fill];
    }];
    [self.view addSubview:img];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (UIImage *) imageWithSize:(CGSize)size customDraw:(void(^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    drawBlock(context);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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
