//
//  FiveViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/8/2.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "FiveViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface FiveViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate> {
//    dispatch_queue_t _recoding_queue;
    dispatch_queue_t _mete_queue;
    
    UIView *_highlightView;
    UILabel *_infoLabel;
}
@property (nonatomic, weak) AVCaptureSession *videoSession;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *avLayer;
//@property (nonatomic, weak) AVCaptureVideoDataOutput *videoDataOut;
//@property (nonatomic, weak) AVCaptureAudioDataOutput *audioDataOut;
@property (nonatomic, weak) AVCaptureMetadataOutput *metaDataOut;

@end

@implementation FiveViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.videoSession stopRunning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self setupVideo];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 20, 60, 40);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"切换" forState:UIControlStateNormal];
    changeBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 80, 20, 60, 40);
    [changeBtn addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)changeAction {
    NSArray *inputArr = self.videoSession.inputs;
    for (AVCaptureDeviceInput *input in inputArr) {
        AVCaptureDevice *device = input.device;
        if ([device hasMediaType:AVMediaTypeVideo]) {
            AVCaptureDevicePosition position = device.position;
            
            AVCaptureDevice *newCamara = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionBack) {
                newCamara = [self camaraWithPosition:AVCaptureDevicePositionFront];
            }
            else
                newCamara = [self camaraWithPosition:AVCaptureDevicePositionBack];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamara error:nil];
            [self.videoSession beginConfiguration];
            [self.videoSession removeInput:input];
            [self.videoSession addInput:newInput];
            
            [self.videoSession commitConfiguration];
            break;
        }
    }
}

- (AVCaptureDevice *)camaraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devideArr = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devideArr) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (void)setupVideo {
//    _recoding_queue = dispatch_queue_create("com.kzsmallvideo.queue", DISPATCH_QUEUE_SERIAL);
    _mete_queue = dispatch_queue_create("com.houkangzhu.mete", DISPATCH_QUEUE_SERIAL);
    
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSArray *audioDevides = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevices[0] error:nil];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevides[0] error:nil];
    
//    AVCaptureVideoDataOutput *videoDataOut = [[AVCaptureVideoDataOutput alloc] init];
//    videoDataOut.videoSettings = @{(__bridge NSString *)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)};
//    videoDataOut.alwaysDiscardsLateVideoFrames = YES;
//    [videoDataOut setSampleBufferDelegate:self queue:_recoding_queue];
//    self.videoDataOut = videoDataOut;
//    
//    AVCaptureAudioDataOutput *audioDataOut = [[AVCaptureAudioDataOutput alloc] init];
//    [audioDataOut setSampleBufferDelegate:self queue:_recoding_queue];
//    self.audioDataOut = audioDataOut;
    
    AVCaptureMetadataOutput *metaDataOut = [[AVCaptureMetadataOutput alloc] init];
    [metaDataOut setMetadataObjectsDelegate:self queue:_mete_queue];
    self.metaDataOut = metaDataOut;
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    if ([session canAddInput:videoInput]) {
        [session addInput:videoInput];
    }
    if ([session canAddInput:audioInput]) {
        [session addInput:audioInput];
    }
    if ([session canAddOutput:metaDataOut]) {
        [session addOutput:metaDataOut];
    }
//    if ([session canAddOutput:videoDataOut]) {
//        [session addOutput:videoDataOut];
//    }
//    if ([session canAddOutput:audioDataOut]) {
//        [session addOutput:audioDataOut];
//    }
    
    AVCaptureVideoPreviewLayer *avLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    avLayer.frame = self.view.bounds;
    avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:avLayer];
    self.avLayer = avLayer;
    
    self.videoSession = session;
    [self setupMetaObjects];
    
    [session startRunning];
}

- (void)setupMetaObjects {
    self.metaDataOut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeFace];
    
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 1;
    [self.view addSubview:_highlightView];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 40, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.text = @"";
    _infoLabel.font = [UIFont systemFontOfSize:12];
    _infoLabel.numberOfLines = 0;
    [self.view addSubview:_infoLabel];
}

//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    if (captureOutput == self.videoDataOut) {
////        NSLog(@"video output");
//        @autoreleasepool {
//            CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//            CVReturn status = CVPixelBufferLockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
//            if (status == kCVReturnSuccess) {
//                size_t pixSize = CVPixelBufferGetDataSize(pixelBuffer);
//                void *pixAddress = CVPixelBufferGetBaseAddress(pixelBuffer);
//                
//                CVPixelBufferUnlockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
//            }
//        }
//    }
//    else {
////        NSLog(@"audio output");
//    }
//}

//
//- (void)rentNew:(CMSampleBufferRef)sampleBuffer {
//   
//}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataFaceObject *faceObj = nil;
    AVMetadataMachineReadableCodeObject *erweimaObj = nil;
    CGRect objFrame = CGRectZero;
    NSString *code = nil;
    for (AVMetadataObject *metaData in metadataObjects) {
        if ([metaData.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            erweimaObj = (AVMetadataMachineReadableCodeObject *)[self.avLayer transformedMetadataObjectForMetadataObject:metaData];
            objFrame = erweimaObj.bounds;
            code = erweimaObj.stringValue;
            break;
        }
        if ([metaData.type isEqualToString:AVMetadataObjectTypeFace]) {
            faceObj = (AVMetadataFaceObject *)[self.avLayer transformedMetadataObjectForMetadataObject:metaData];
            objFrame = faceObj.bounds;
            code = @"发现一张脸";
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _highlightView.frame = objFrame;
        _infoLabel.text = code;
        NSLog(@"---- %@ -", code);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
