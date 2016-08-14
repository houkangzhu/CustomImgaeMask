//
//  SixViewController.m
//  CustomImgaeMask
//
//  Created by HouKangzhu on 16/8/4.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

#import "SixViewController.h"
#import <GPUImage/GPUImage.h>

@interface SixViewController ()<GPUImageVideoCameraDelegate> {
    NSInteger _index;
    UILabel *_infoLabel;
}
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong) NSArray *filterArr;

@end

@implementation SixViewController

- (NSArray *)filterArr  {
    NSArray *arr = @[@"GPUImageBeautifyFilter",
                     @"GPUImage3x3ConvolutionFilter",
                     @"GPUImage3x3TextureSamplingFilter",
                     @"GPUImageAdaptiveThresholdFilter",
                     @"GPUImageAddBlendFilter",
                     @"GPUImageAlphaBlendFilter",
                     @"GPUImageAmatorkaFilter",
                     @"GPUImageAverageLuminanceThresholdFilter",
                     @"GPUImageBilateralFilter",
                     @"GPUImageBoxBlurFilter",
                     @"GPUImageBrightnessFilter",
                     @"GPUImageBulgeDistortionFilter",
                     @"GPUImageCannyEdgeDetectionFilter",
                     @"GPUImageCGAColorspaceFilter",
                     @"GPUImageChromaKeyBlendFilter",
                     @"GPUImageChromaKeyFilter",
                     @"GPUImageClosingFilter",
                     @"GPUImageColorBlendFilter",
                     @"GPUImageColorBurnBlendFilter",
                     @"GPUImageColorDodgeBlendFilter",
                     @"GPUImageColorInvertFilter",
                     @"GPUImageColorMatrixFilter",
                     @"GPUImageColorPackingFilter",
                     @"GPUImageContrastFilter",
                     @"GPUImageCropFilter",
                     @"GPUImageCrosshatchFilter",
                     @"GPUImageDarkenBlendFilter",
                     @"GPUImageDifferenceBlendFilter",
                     @"GPUImageDilationFilter",
                     @"GPUImageDirectionalNonMaximumSuppressionFilter",
                     @"GPUImageDirectionalSobelEdgeDetectionFilter",
                     @"GPUImageDissolveBlendFilter",
                     @"GPUImageDivideBlendFilter",
                     @"GPUImageEmbossFilter",
                     @"GPUImageErosionFilter",
                     @"GPUImageExclusionBlendFilter",
                     @"GPUImageExposureFilter",
                     @"GPUImageFalseColorFilter",
                     @"GPUImageFASTCornerDetectionFilter",
                     @"GPUImageFilter",
                     @"GPUImageGammaFilter",
                     @"GPUImageGaussianBlurFilter",
                     @"GPUImageGaussianBlurPositionFilter",
                     @"GPUImageGaussianSelectiveBlurFilter",
                     @"GPUImageGlassSphereFilter",
                     @"GPUImageGrayscaleFilter",
                     @"GPUImageHalftoneFilter",
                     @"GPUImageHardLightBlendFilter",
                     @"GPUImageHarrisCornerDetectionFilter",
                     @"GPUImageHazeFilter",
                     @"GPUImageHighlightShadowFilter",
                     @"GPUImageHighPassFilter",
                     @"GPUImageHistogramEqualizationFilter",
                     @"GPUImageHistogramFilter",
                     @"GPUImageHSBFilter",
                     @"GPUImageHueBlendFilter",
                     @"GPUImageHueFilter",
                     @"GPUImageiOSBlurFilter",
                     @"GPUImageJFAVoronoiFilter",
                     @"GPUImageKuwaharaFilter",
                     @"GPUImageKuwaharaRadius3Filter",
                     @"GPUImageLanczosResamplingFilter",
                     @"GPUImageLaplacianFilter",
                     @"GPUImageLevelsFilter",
                     @"GPUImageLightenBlendFilter",
                     @"GPUImageLinearBurnBlendFilter",
                     @"GPUImageLocalBinaryPatternFilter",
                     @"GPUImageLookupFilter",
                     @"GPUImageLowPassFilter",
                     @"GPUImageLuminanceRangeFilter",
                     @"GPUImageLuminanceThresholdFilter",
                     @"GPUImageLuminosityBlendFilter",
                     @"GPUImageMaskFilter",
                     @"GPUImageMedianFilter",
                     @"GPUImageMissEtikateFilter",
                     @"GPUImageMonochromeFilter",
                     @"GPUImageMosaicFilter",
                     @"GPUImageMotionBlurFilter",
                     @"GPUImageMultiplyBlendFilter",
                     @"GPUImageNobleCornerDetectionFilter",
                     @"GPUImageNonMaximumSuppressionFilter",
                     @"GPUImageNormalBlendFilter",
                     @"GPUImageOpacityFilter",
                     @"GPUImageOpeningFilter",
                     @"GPUImageOverlayBlendFilter",
                     @"GPUImageParallelCoordinateLineTransformFilter",
                     @"GPUImagePerlinNoiseFilter",
                     @"GPUImagePinchDistortionFilter",
                     @"GPUImagePixellateFilter",
                     @"GPUImagePixellatePositionFilter",
                     @"GPUImagePoissonBlendFilter",
                     @"GPUImagePolarPixellateFilter",
                     @"GPUImagePolkaDotFilter",
                     @"GPUImagePosterizeFilter",
                     @"GPUImagePrewittEdgeDetectionFilter",
                     @"GPUImageRGBClosingFilter",
                     @"GPUImageRGBDilationFilter",
                     @"GPUImageRGBErosionFilter",
                     @"GPUImageRGBFilter",
                     @"GPUImageRGBOpeningFilter",
                     @"GPUImageSaturationBlendFilter",
                     @"GPUImageSaturationFilter",
                     @"GPUImageScreenBlendFilter",
                     @"GPUImageSepiaFilter",
                     @"GPUImageSharpenFilter",
                     @"GPUImageShiTomasiFeatureDetectionFilter",
                     @"GPUImageSingleComponentGaussianBlurFilter",
                     @"GPUImageSketchFilter",
                     @"GPUImageSmoothToonFilter",
                     @"GPUImageSobelEdgeDetectionFilter",
                     @"GPUImageSoftEleganceFilter",
                     @"GPUImageSoftLightBlendFilter",
                     @"GPUImageSourceOverBlendFilter",
                     @"GPUImageSphereRefractionFilter",
                     @"GPUImageStretchDistortionFilter",
                     @"GPUImageSubtractBlendFilter",
                     @"GPUImageSwirlFilter",
                     @"GPUImageThreeInputFilter",
                     @"GPUImageThresholdEdgeDetectionFilter",
                     @"GPUImageThresholdedNonMaximumSuppressionFilter",
                     @"GPUImageThresholdSketchFilter",
                     @"GPUImageTiltShiftFilter",
                     @"GPUImageToneCurveFilter",
                     @"GPUImageToonFilter",
                     @"GPUImageTransformFilter",
                     @"GPUImageTwoInputCrossTextureSamplingFilter",
                     @"GPUImageTwoInputFilter",
                     @"GPUImageTwoPassFilter",
                     @"GPUImageTwoPassTextureSamplingFilter",
                     @"GPUImageUnsharpMaskFilter",
                     @"GPUImageVignetteFilter",
                     @"GPUImageVoronoiConsumerFilter",
                     @"GPUImageWeakPixelInclusionFilter",
                     @"GPUImageWhiteBalanceFilter",
                     @"GPUImageXYDerivativeFilter",
                     @"GPUImageZoomBlurFilter"
                     ];
    return arr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.videoCamera stopCameraCapture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    
    self.filterView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.filterView.center = self.view.center;
    [self.view addSubview:self.filterView];
    
    
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    self.videoCamera.delegate = self;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 30)];
    [btn setTitle:@"滤镜" forState:UIControlStateNormal];
    [btn setTitle:@"关闭" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, 100, 30)];
    [nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:nextBtn];
    
    UIButton *lastBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, 100, 30)];
    [lastBtn setTitle:@"上一个" forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    lastBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:lastBtn];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 40, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
    _infoLabel.textColor = [UIColor whiteColor];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.text = @"";
    _infoLabel.font = [UIFont systemFontOfSize:14];
    _infoLabel.numberOfLines = 0;
    _infoLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_infoLabel];
    
    _index = -1;
}

- (void)filterAction:(UIButton *)btn {
    if (!btn.selected) {
        [self.videoCamera removeAllTargets];
        
        NSString *className = self.filterArr[_index];
        Class filterClass = NSClassFromString(className);
        GPUImageFilter *filter = [[filterClass alloc] init];
        [self.videoCamera addTarget:filter];
        [filter addTarget:self.filterView];
    }
    else {
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.filterView];
    }
    btn.selected = !btn.selected;
}

- (void)lastAction {
    if ( --_index <= 0)  _index = self.filterArr.count - 1;
    [self changeFiterWithIndex:_index];
}

- (void)nextAction {
    if ( ++_index >= self.filterArr.count)  _index = 0;
    [self changeFiterWithIndex:_index];
}

- (void)changeFiterWithIndex:(NSInteger)index {
    [self.videoCamera removeAllTargets];
    
    NSString *className = self.filterArr[index];
    Class filterClass = NSClassFromString(className);
    GPUImageFilter *filter = [[filterClass alloc] init];
    [self.videoCamera addTarget:filter];
    [filter addTarget:self.filterView];
    
    _infoLabel.text = className;
}


- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
