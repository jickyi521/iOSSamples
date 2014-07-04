//
//  JYTLoadingView.m
//  iOSSamples
//
//  Created by EasonQian on 5/28/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTLoadingView.h"


static JYTLoadingView *instance;
static NSTimer *timer;

@interface JYTLoadingView(){
    
}

@property(strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation JYTLoadingView


+(JYTLoadingView *)getShareInstance{
    
    if(!instance){
        instance = [[JYTLoadingView alloc] init];
    }
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"JYTLoadingView" owner:self options:nil] objectAtIndex:0];
        
        CGRect frame = [UIScreen mainScreen].bounds;
        self.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        self.layer.cornerRadius = 8.0;
    }
    return self;
}

+(void)show{
    
    [[[JYTLoadingView getShareInstance] indicatorView] startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview: [JYTLoadingView getShareInstance]];
     timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stop) userInfo:nil repeats:NO];
}

+(void)stop{
    [[self getShareInstance] removeFromSuperview];
}

@end
