//
//  JYTTouchButton.m
//  iOSSamples
//
//  Created by EasonQian on 8/14/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTTouchButton.h"

@interface JYTTouchButton()

@property (nonatomic) CGPoint startTouchPosition;

@end

@implementation JYTTouchButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    // startTouchPosition是一个CGPoint类型的属性，用来存储当前touch事件的位置
    self.startTouchPosition = [aTouch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    //获取当前触摸操作的位置坐标
    CGPoint loc = [aTouch locationInView:self];
    //获取上一个触摸点的位置坐标
    CGPoint prevloc = [aTouch previousLocationInView:self];
    
    CGRect myFrame = self.frame;
    //改变View的x、y坐标值
    float deltaX = loc.x - prevloc.x;
    float deltaY = loc.y - prevloc.y;
    myFrame.origin.x += deltaX;
    myFrame.origin.y += deltaY;
    //重新设置View的显示位置
    [self setFrame:myFrame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *aTouch in touches) {
        if (aTouch.tapCount == 2) {
            // 处理双击事件
            NSLog(@"Double touch");
        }
    }
    
    UITouch *aTouch = [touches anyObject];
    CGPoint currentTouchPosition = [aTouch locationInView:self];
    
    //  判断水平滑动的距离是否达到了设置的最小距离，并且是否是在接近直线的路线上滑动（y轴偏移量）
    if (fabsf(self.startTouchPosition.x - currentTouchPosition.x) >= HORIZ_SWIPE_DRAG_MIN &&
        fabsf(self.startTouchPosition.y - currentTouchPosition.y) <= VERT_SWIPE_DRAG_MAX)
    {
        // 满足if条件则认为是一次成功的滑动事件，根据x坐标变化判断是左滑还是右滑
        if (self.startTouchPosition.x < currentTouchPosition.x) {
            NSLog(@"rightSwipe");;//右滑响应方法
        } else {
            NSLog(@"leftSwipe");//左滑响应方法
        }
        //重置开始点坐标值
        self.startTouchPosition = CGPointZero;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
