//
//  JYTMoveToTrashViewController.m
//  iOSSamples
//
//  Created by EasonQian on 4/11/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTMoveToTrashViewController.h"
#import "GLBucket.h"


static NSString *kAnimationNameKey = @"animation_name";
static NSString *kScrapDriveUpAnimationName = @"scrap_drive_up_animation";
static NSString *kScrapDriveDownAnimationName = @"scrap_drive_down_animation";
static NSString *kBucketDriveUpAnimationName = @"bucket_drive_up_animation";
static NSString *kBucketDriveDownAnimationName = @"bucket_drive_down_animation";

static const CGFloat kScrapDriveUpAnimationHeight = 200;
static const CGFloat kScrapYOffsetFromBase = 7;


@interface JYTMoveToTrashViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) CALayer *scrapLayer;
@property (nonatomic, strong) CALayer *bucketContainerLayer;
@property (nonatomic, strong) GLBucket *bucket;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CGFloat baseviewYOrigin;
@property (nonatomic, assign) CGFloat bucketContainerLayerActualYPos;
@end

@implementation JYTMoveToTrashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (CGRect)CGRectIntegralCenteredInRect:(CGRect)innerRect withRect:(CGRect)outerRect
{
    CGFloat originX = floorf((outerRect.size.width - innerRect.size.width) * 0.5f);
    CGFloat originY = floorf((outerRect.size.height - innerRect.size.height) * 0.5f);
    CGRect bounds = CGRectMake(originX, originY, innerRect.size.width, innerRect.size.height);
    return bounds;
}

- (void)loadView
{
    [super loadView];
    
    
    // set base view y origin
    CGRect rect = [self CGRectIntegralCenteredInRect:CGRectMake(0, 0, 200, 40) withRect:self.view.frame];
    self.baseviewYOrigin = rect.origin.y + 100;
    
    
    // animation start button
    rect.origin.y = self.baseviewYOrigin;
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = rect;
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = [UIColor grayColor];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTitle:@"Move to trash" forState:UIControlStateNormal];
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:self.button];
    
    
    // scrap layer
    UIImage *img = [UIImage imageNamed:@"input_mic.png"];
    rect = [self CGRectIntegralCenteredInRect:CGRectMake(0, 0, img.size.width - 5, img.size.height - 5) withRect:self.view.frame];
    rect.origin.y = self.baseviewYOrigin - CGRectGetHeight(rect) - kScrapYOffsetFromBase;
    
    self.scrapLayer = [CALayer layer];
    self.scrapLayer.frame = rect;
    self.scrapLayer.bounds = rect;
    [self.scrapLayer setContents:(id)img.CGImage];
    [self.view.layer addSublayer:self.scrapLayer];
    
    
    // trash layer
    rect = [self CGRectIntegralCenteredInRect:CGRectMake(0, 0, 50, CGRectGetHeight(self.button.bounds)) withRect:self.view.frame];
    rect.origin.y = self.baseviewYOrigin;
    
    self.bucketContainerLayer = [CALayer layer];
    self.bucketContainerLayer.frame = rect;
    self.bucketContainerLayer.bounds = rect;
    self.bucketContainerLayer.hidden = YES;
    [self.view.layer addSublayer:self.bucketContainerLayer];
    
    
    // bucket layer
    CGRect centeredRect = [self CGRectIntegralCenteredInRect:CGRectMake(0, 0, 22, 20 + 12) withRect:rect]; //image size(20x32)
    centeredRect.origin.x = CGRectGetMinX(rect) + CGRectGetMinX(centeredRect);
    centeredRect.origin.y = CGRectGetMinY(rect);
    
    self.bucket = [[GLBucket alloc] initWithFrame:centeredRect inLayer:self.bucketContainerLayer];
    self.bucket.bucketStyle = BucketStyle2OpenFromRight;
    
    
    // set bucket-container-layer actual y origin
    self.bucketContainerLayerActualYPos = self.baseviewYOrigin - (self.bucket.actualHeight / 2) - kScrapYOffsetFromBase; //divide by 2 considering center from y-axis
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set animation duration
    self.duration = 0.6;
    
    // configure zindex of each and every layers/views
    self.button.layer.zPosition = 99;
    self.bucketContainerLayer.zPosition = 98;
    self.scrapLayer.zPosition = 97;
}

- (void)buttonAction:(id)sender
{
    [self.button setTitle:@"" forState:UIControlStateNormal];
    [self.button setEnabled:NO];
    [self scrapDriveUpAnimation];
}

#pragma mark - Animation boilerplate

- (void)scrapDriveUpAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.scrapLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.scrapLayer.frame), CGRectGetMidY(self.scrapLayer.frame) - kScrapDriveUpAnimationHeight)];
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    NSArray* keyFrameValues = @[
                                @(0.0),
                                @(M_PI),
                                @(M_PI*1.5),
                                @(M_PI*2.0)
                                ];
    CAKeyframeAnimation* rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [rotateAnimation setValues:keyFrameValues];
    [rotateAnimation setValueFunction:[CAValueFunction functionWithName: kCAValueFunctionRotateZ]];
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.delegate = self;
    [animGroup setValue:kScrapDriveUpAnimationName forKey:kAnimationNameKey];
    animGroup.animations = @[moveAnimation, rotateAnimation];
    //animGroup.animations = @[rotateAnimation];
    animGroup.duration = self.duration;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    [self.scrapLayer addAnimation:animGroup forKey:nil];
}

- (void)scrapDriveDownAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.delegate = self;
    [moveAnimation setValue:kScrapDriveDownAnimationName forKey:kAnimationNameKey];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.scrapLayer.position.x, self.scrapLayer.position.y - 5)];
    moveAnimation.duration = self.duration;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.scrapLayer addAnimation:moveAnimation forKey:nil];
}

- (void)bucketDriveUpAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.delegate = self;
    [moveAnimation setValue:kBucketDriveUpAnimationName forKey:kAnimationNameKey];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.bucketContainerLayer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.scrapLayer.frame), self.bucketContainerLayerActualYPos)];
    moveAnimation.duration = self.duration;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.bucketContainerLayer addAnimation:moveAnimation forKey:nil];
}

- (void)bucketDriveDownAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.delegate = self;
    [moveAnimation setValue:kBucketDriveDownAnimationName forKey:kAnimationNameKey];
    moveAnimation.toValue = [NSValue valueWithCGPoint:self.bucketContainerLayer.position];
    moveAnimation.duration = self.duration;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.bucketContainerLayer addAnimation:moveAnimation forKey:nil];
}

#pragma mark - Animation Delegate methods

- (void)animationDidStart:(CAAnimation *)anim
{
    NSString *animationName = [anim valueForKey:kAnimationNameKey];
    if ([animationName isEqualToString:kScrapDriveDownAnimationName]) {
        [self bucketDriveUpAnimation];
        
    } else if ([animationName isEqualToString:kBucketDriveUpAnimationName]) {
        self.bucketContainerLayer.hidden = NO;
        [self.bucket performSelector:@selector(openBucket) withObject:nil afterDelay:self.duration * 0.3];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        NSString *animationName = [anim valueForKey:kAnimationNameKey];
        if ([animationName isEqualToString:kScrapDriveUpAnimationName]) {
            [self performSelector:@selector(scrapDriveDownAnimation) withObject:nil afterDelay:self.duration * 0.1];
            
        } else if ([animationName isEqualToString:kScrapDriveDownAnimationName]) {
            self.scrapLayer.hidden = YES;
            [self.bucket performSelector:@selector(closeBucket) withObject:nil afterDelay:self.duration * 0.1];
            [self performSelector:@selector(bucketDriveDownAnimation) withObject:nil afterDelay:self.duration * 1.0];
            
        } else if ([animationName isEqualToString:kBucketDriveDownAnimationName]) {
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            int udCount = 5;
            int width = self.view.frame.size.width / udCount ;
            int xOffset = 150;
            int yOffset = 200;
            int waveHeight = 50;
            CGPoint p1 = CGPointMake(width * -1 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p2 = CGPointMake(width * 0 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p3 = CGPointMake(width * 1 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p4 = CGPointMake(width * 2 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p5 = CGPointMake(width * 3 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p6 = CGPointMake(width * 4 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p7 = CGPointMake(width * 5 + xOffset, self.view.frame.origin.y + yOffset);
            CGPoint p8 = CGPointMake(width * 7 + xOffset, self.view.frame.origin.y + yOffset);
            
            
            CGPathMoveToPoint(path, NULL, p1.x,p1.y);
            
            //生成曲线路径
            CGPathAddQuadCurveToPoint(path, NULL, p1.x+width/2, p1.y - waveHeight, p2.x, p2.y);
            CGPathAddQuadCurveToPoint(path, NULL, p2.x+width/2, p2.y + waveHeight, p3.x, p3.y);
            CGPathAddQuadCurveToPoint(path, NULL, p3.x+width/2, p3.y - waveHeight, p4.x, p4.y);
            CGPathAddQuadCurveToPoint(path, NULL, p4.x+width/2, p4.y + waveHeight, p5.x, p5.y);
            CGPathAddQuadCurveToPoint(path, NULL, p5.x+width/2, p5.y - waveHeight, p6.x, p6.y);
            CGPathAddQuadCurveToPoint(path, NULL, p6.x+width/2, p6.y + waveHeight, p7.x, p7.y);
            CGPathAddQuadCurveToPoint(path, NULL, p7.x+width/2, p7.y - waveHeight, p8.x, p8.y);
            
            
            
            
            
           // CGPathMoveToPoint(path, NULL, 0, 64);
            //CGPathAddQuadCurveToPoint(path, NULL, x1, y1, x2, y2);
            
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.path = path;
            pathAnimation.duration = 5.0;
            [self.bucketContainerLayer addAnimation:pathAnimation forKey:nil];
            
            
            //self.bucketContainerLayer.hidden = YES;
            self.scrapLayer.hidden = NO;
            [self.button setTitle:@"Press me to kick off again!!" forState:UIControlStateNormal];
            [self.button setEnabled:YES];
        }
    }
}

@end

