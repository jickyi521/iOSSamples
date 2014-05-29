//
//  JYTLoadingView.m
//  iOSSamples
//
//  Created by EasonQian on 5/28/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTLoadingView.h"


static JYTLoadingView *instance;

@interface JYTLoadingView(){
    NSTimer *timer;
}


@property(strong, nonatomic) IBOutlet UIView *mainLoadingView;
@property(strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property(strong, nonatomic) IBOutlet UILabel *loadingLable;

@end

@implementation JYTLoadingView

+(id)getShareInstance{
    
    if(!instance){
        instance = [[JYTLoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return instance;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JYTLoadingView" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        self.mainLoadingView.center = self.center;
        [self.indicatorView startAnimating];
       
    }
    return self;
}


-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
     timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stop) userInfo:nil repeats:NO];
    
}

-(void)stop{
    [self removeFromSuperview];
}

@end
