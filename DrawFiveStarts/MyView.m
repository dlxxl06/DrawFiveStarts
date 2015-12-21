//
//  MyView.m
//  DrawFiveStarts
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyView.h"
@interface MyView()
{
    CGPoint _points[5];
}
@end
@implementation MyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctr= UIGraphicsGetCurrentContext();
    [self draw5Starts:ctr count:10];
    //[self drawRadialGradients];
}
-(void)draw5Starts:(CGContextRef )ctr count:(NSInteger)count;
{
    for (NSInteger num = 1; num<=count; num++) {
         CGContextSaveGState(ctr);
        
        
        //平移
        CGFloat x = arc4random_uniform(375);
        CGFloat y = arc4random_uniform(667);
        CGContextTranslateCTM(ctr, x, y);
        //缩放
        CGFloat sx = arc4random_uniform(5)/10.0+0.5;
        CGContextScaleCTM(ctr, sx, sx);
        //旋转
        CGFloat angle = arc4random_uniform(180)*M_PI/180;
        CGContextRotateCTM(ctr, angle);
        [self draw5Start:ctr];
        CGContextRestoreGState(ctr);
    }
}

-(void)draw5Start:(CGContextRef )ctr
{
   
    [self Get5Points];
    [[self randomColor]setFill];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, _points[0].x, _points[0].y);
    for (NSInteger i=1; i<5; i++) {
        CGPathAddLineToPoint(path, nil, _points[i].x, _points[i].y);
    }
    CGPathCloseSubpath(path);
    
    //将路径添加到上下文中
    CGContextAddPath(ctr, path);
    CGContextDrawPath(ctr,  kCGPathFill);
    CGPathRelease(path);
    

}
-(UIColor *)randomColor
{
    CGFloat red = arc4random_uniform(255)/255.0;
    CGFloat green = arc4random_uniform(255)/255.0;
    CGFloat blue = arc4random_uniform(255)/255.0;
    return [[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0];
}
-(void)Get5Points
{
    CGFloat radius = arc4random_uniform(50)+100.0; // 50-100
      CGFloat angle = 4.0*M_PI/5;
    _points[0] = CGPointMake(0, -radius);
    for (NSInteger i=1; i<5; i++) {
        CGFloat x = cos(i*angle - M_PI_2)*radius;
        CGFloat y = sin(i*angle-M_PI_2)*radius;
        _points[i] = CGPointMake(x, y);
    }
}

-(void)drawRadialGradients
{
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGFloat com[8]={0.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0};
    CGFloat loc[2]={0.2,1.0};
    
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(spaceRef, com, loc, 2);
    CGContextDrawRadialGradient(ctr, gradientRef, CGPointMake(10, 10),50.0f, CGPointMake(10, 10), 150.0f, kCGGradientDrawsAfterEndLocation);
    
    //UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGColorSpaceRelease(spaceRef);
    CGGradientRelease(gradientRef);


}
@end
