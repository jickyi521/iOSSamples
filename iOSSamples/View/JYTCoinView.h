//
//  JYTCoinView.h
//  iOSSamples
//
//  Created by EasonQian on 4/9/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYTCoinView : UIView

- (id) initWithPrimaryView: (UIView *) view1 andSecondaryView: (UIView *) view2 inFrame: (CGRect) frame;

@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property float spinTime;


@end
