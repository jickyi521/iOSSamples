//
//  JYTSectorView.m
//  iOSSamples
//
//  Created by EasonQian on 4/4/14.
//  Copyright (c) 2014 jinyuntian. All rights reserved.
//

#import "JYTSectorView.h"

#define PI 3.14159265358979323846
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@implementation JYTSectorView

    NSString *_content;
    UIImage *_normalImage;
    UIImage *_highLightedImage;
    CGFloat _angle = PI/6;
    CGFloat _width;
    CGFloat _height;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _width = self.bounds.size.width;
        _height = self.bounds.size.height;
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    
    UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
    UIColor *color = [UIColor redColor];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: color};
    
    [@"画圆：" drawInRect:CGRectMake(10, 20, 60, 20) withAttributes:attributes];
    
    
    /*画扇形和椭圆*/
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    UIColor *aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, self.bounds.size.width/2, self.bounds.size.height/2);
    
    
    CGContextAddArc(context, _width/2, _height, _height, -(PI-_angle)/2, -(PI + _angle)/2, 1);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    
    
    
    
    self.backgroundColor = [UIColor whiteColor];
}

-(void)initSectorView:(CGFloat) angle content:(NSString *)content normalImage:(UIImage *)normalImage highLightedImage:(UIImage *)highLightedImage action:(SEL)action target:(id)target{
    
    _content = content;
    _normalImage = normalImage;
    _highLightedImage = highLightedImage;
    _angle = angle;
}

@end
