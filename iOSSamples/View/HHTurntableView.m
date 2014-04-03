//
//  HHTurntableView.m
//  demo
//
//  Created by Eric on 12-3-9.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import "HHTurntableView.h"
#import <QuartzCore/QuartzCore.h>
#import "HHPlayAudio.h"
#define kTurntableNum 12
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


@implementation HHTurntableView{
    
    NSInteger currentTag;
    NSInteger preTag;
    BOOL animationIng;
}



- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat angle = DEGREES_TO_RADIANS((360.0/kTurntableNum));
    currentTag = 0;
    for (int i = 0; i < kTurntableNum; i++) 
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.tag = i;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bt_%d.png",i + 1]];
        [button1 setFrame:CGRectMake((viewW - image.size.width)/2.0,0.0 + image.size.height/2.0 ,image.size.width, image.size.height)];
        button1.layer.anchorPoint = CGPointMake(0.5,1.0);
        button1.layer.transform= CATransform3DMakeRotation(angle * i *1.0,0.0, 0.0, 1.0);
        //actualPosition.x = position.x + width*(0.5 - anchor_point.x);
        //acturalPosition.y = position.y + height*(0.5 - anchor_point.y)
        
        [button1 setImage:image forState:UIControlStateNormal];
        image = [UIImage imageNamed:[NSString stringWithFormat:@"bt_selected_%d.png",i + 1]];
        [button1 setImage:image forState:UIControlStateHighlighted];
        [button1 addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
    }
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextScaleCTM(context,1.0,-1.0);
    CGContextTranslateCTM(context, 0,-self.bounds.size.height);
    UIImage *img = [UIImage imageNamed:@"bg_circle.png"];
	CGContextDrawImage(context,self.bounds,img.CGImage);
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    img = [UIImage imageNamed:@"bg_point.png"];
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    CGRect Rect =  CGRectMake((viewW - w)/2.0,(viewH -h)/2.0 + 60,w,h);
	CGContextDrawImage(context,Rect,img.CGImage);
    
    
    img = [UIImage imageNamed:@"bg_center.png"];
    w = img.size.width;
    h = img.size.height;
    Rect =  CGRectMake((viewW - w)/2.0,(viewH -h)/2.0,w,h);
	CGContextDrawImage(context,Rect,img.CGImage);
    
    CGContextRestoreGState(context);

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (CGFloat)getAngle:(NSInteger)current endTag:(NSInteger)end
{
    int tmp = kTurntableNum/2;
    if (end > tmp)
    {
        return  DEGREES_TO_RADIANS((kTurntableNum - end) * (360.0/kTurntableNum));
    }
    else 
    {
        return DEGREES_TO_RADIANS(-end * (360.0 /kTurntableNum));
    }
}

- (void)buttonDown:(id)sender
{
    //kIsAdShow;
    UIButton *button = (UIButton *)sender;
    if (button.tag == currentTag)
    {
        return;
    }
    
    if (!animationIng)
    {
        animationIng = YES;
        
        //[HHPlayAudio playAudio:@"Tink.wav"];//播放声音
        
        
        [self performSelector:@selector(pauseLayer:) withObject:self.layer afterDelay:5];
        
        currentTag = button.tag;
        preTag = currentTag;
        
        
        [self startCycleLoopAnimation];
        //[self startRotate2:UIViewAnimationOptionCurveEaseIn];
        //[self lastSpin:2];
        //[self startRoate1:0.0];
        //[self startRoate3];
    }
    
}

-(void)startCycleLoopAnimation{
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    //animation.speed=2;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:5 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [animation setValue:@"startCycleLoopAnimation" forKey:@"animType"];
    
    [self.layer addAnimation:animation forKey:@"startCycleLoopAnimation"];
    [CATransaction commit];
}

-(void)shakeToAwardAnimation{
    
    [UIView animateWithDuration: 1.0f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         
                         CABasicAnimation *animation;
                         animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                         animation.duration = 5;
                         
                         animation.fillMode = kCAFillModeForwards;
                         animation.removedOnCompletion = NO;
                         animation.fromValue = [NSNumber numberWithFloat:0.0];
                         animation.toValue = [NSNumber numberWithFloat:(10 * M_PI + [self getAngle:preTag endTag:currentTag])];
                         animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
                         animation.delegate = self;
                          [animation setValue:@"shakeToAwardAnimation" forKey:@"animType"];
                         [self.layer addAnimation:animation forKey:@"shakeToAwardAnimation"];
                         [CATransaction commit];
                         
                     }
                     completion: ^(BOOL finished) {
                         self.layer.transform = CATransform3DMakeRotation([self getAngle:preTag endTag:currentTag],0.0, 0.0, 1.0);
                     }];

}


- (void)animationStop
{
    animationIng = NO;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if([[anim valueForKey:@"animType"] isEqualToString:@"startCycleLoopAnimation"]){
        if(flag && animationIng){
            [self startCycleLoopAnimation];
        }else if(flag && !animationIng){
            [self shakeToAwardAnimation];
        }
    }
    
}












-(void)startRoate1:(CGFloat) angle{
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:0];
    
    if(angle >= 0){
        angle += 2*M_PI;
    }else{
        angle -= 2*M_PI;
    }

    shake.toValue = [NSNumber numberWithFloat:(angle)];
    shake.duration = 1;
    shake.autoreverses = NO;
    shake.repeatCount = 1;
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.alpha = 1;
    
    shake.fillMode = kCAFillModeForwards;
    shake.removedOnCompletion = NO;
    
    [UIView animateKeyframesWithDuration:10.0 delay:0.0 options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        
        if(animationIng){
            [self startRoate1:0];
        }
    } completion:^(BOOL finished) {
        //animationIng = NO;
    }];
    
}

-(void)startRoate1{
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:0];
    
    shake.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    
    shake.duration = 1;
    shake.autoreverses = NO;
    shake.repeatCount = 1;
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.alpha = 1;
    
    shake.fillMode = kCAFillModeForwards;
    shake.removedOnCompletion = NO;
    
    [UIView animateKeyframesWithDuration:10.0 delay:0.0 options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 0.8;
    } completion:^(BOOL finished) {
        //animationIng = NO;
        if(animationIng){
            [self startRoate1];
        }else{
            [self startRoate1:M_PI/6];
        }
    }];
    
}

-(void)startRotate2: (UIViewAnimationOptions) options {
    
   
    // this spin completes 360 degrees every 2 seconds
    [UIView animateWithDuration: 1.0f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         
                         
                         
                         CABasicAnimation *animation;
                         animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                         //animation.duration = 1;
                         //animation.speed=2;
                         animation.fromValue = [NSNumber numberWithFloat:0.0];
                         animation.toValue = [NSNumber numberWithFloat:4 * M_PI];
                         animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
                         animation.delegate = self;
                         [self.layer addAnimation:animation forKey:@"rotationAnimation"];
                         [CATransaction commit];

//                         
//                         [CATransaction begin];
//                         
//                         CABasicAnimation *animation;
//                         animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//                         animation.duration = 1;
//                         //animation.speed=2;
//                         animation.fromValue = [NSNumber numberWithFloat:0.0];
//                         animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
//                         animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
//                         animation.delegate = self;
//                         [self.layer addAnimation:animation forKey:@"rotationAnimation"];
//                         [CATransaction commit];
                         
                         
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animationIng) {
                                 // if flag still set, keep spinning with constant speed
                                 [self startRotate2: UIViewAnimationOptionCurveEaseIn];
                             }else{
                                 [self lastSpin:2];
                             }
                             
                             
//                             else if (options != UIViewAnimationOptionCurveEaseOut) {
//                                 // one last spin, with deceleration
//                                 //[self startRotate2: UIViewAnimationOptionCurveEaseOut];
//                             }else{
//                                 //[self lastSpin:2];
//                             }
                         }
                     }];
}


-(void)lastSpin:(NSInteger)count{
    
    count --;
    [UIView animateWithDuration: 1.0f
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
                         
                         CABasicAnimation *animation;
                         animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                         if(count == 1){
                             animation.duration = 5;
                         }else{
                             
                             animation.duration = count;
                         }
                         //animation.speed=count;
                         
                         animation.fillMode = kCAFillModeForwards;
                         animation.removedOnCompletion = NO;
                         
                         
                         animation.fromValue = [NSNumber numberWithFloat:0.0];
                         animation.toValue = [NSNumber numberWithFloat:(10 * M_PI + [self getAngle:preTag endTag:currentTag])];
                         animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
                         animation.delegate = self;
                         [self.layer addAnimation:animation forKey:@"rotationAnimation"];
                         [CATransaction commit];
                         
                     }
                     completion: ^(BOOL finished) {
//                         if (finished) {
//                             if(count > 1){
//                                 [self lastSpin:count];
//                             }
//                             else{
                                 self.layer.transform = CATransform3DMakeRotation([self getAngle:preTag endTag:currentTag],0.0, 0.0, 1.0);
//                             }
//                         }
                     }];
    
    

}

- (void) startSpin {
    [self startRotate2: UIViewAnimationOptionCurveEaseIn];
    
}

- (void) stopSpin {
    // set the flag to stop spinning after one last 90 degree increment
    animationIng = NO;
}


- (void)pauseLayer:(CALayer*)layer
{//暂停转动
    animationIng = NO;
//    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    layer.speed= 0.0;
//    layer.timeOffset= pausedTime;
}

- (void)startRoate3
{//创建动画并转动
//    [CATransaction begin];
//    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//    CGRect frame = [self frame];
//    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    self.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
//    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    //animation.speed=2;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:5 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
}





@end
