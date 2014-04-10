//
//  JYTSectorView.h
//  iOSSamples
//
//  Created by EasonQian on 4/4/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface JYTSectorView : UIView


//@property(nonatomic) SEL action;
//@property(nonatomic, assign) id target;
//@property(nonatomic, strong) NSString *content;
//@property(nonatomic, strong) UIImage *normalImage;
//@property(nonatomic, strong) UIImage *highLightedImage;


-(void)initSectorView:(CGFloat) angle content:(NSString *)content normalImage:(UIImage *)normalImage highLightedImage:(UIImage *)highLightedImage action:(SEL)action target:(id)target;

@end
