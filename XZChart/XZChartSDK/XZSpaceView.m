//
//  XZSpaceView.m
//  XZChart
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZSpaceView.h"

#import "XZChartConst.h"

@implementation XZSpaceView


/**
 柱状图间隙渐变色
 
 @param frame 间隙frame
 @param firstPoint 左上角不确定点坐标
 @param secondPoint 右上角不确定点坐标
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame firstPoint:(CGPoint)firstPoint secondPoint:(CGPoint)secondPoint
{
    if (self = [super initWithFrame:frame]) {
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.strokeEnd   = 0.0;
        
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        
        [progressline moveToPoint:firstPoint];
//        [progressline setLineWidth:2.0];
//        [progressline setLineCapStyle:kCGLineCapRound];
//        [progressline setLineJoinStyle:kCGLineJoinRound];
        
//        CGPoint point1 = CGPointMake(secondPoint.x, secondPoint.y);
        [progressline addLineToPoint:secondPoint];
        
        CGPoint point2 = CGPointMake(secondPoint.x, frame.size.height);
        [progressline addLineToPoint:point2];
        
        CGPoint point3 = CGPointMake(0, frame.size.height);
        [progressline addLineToPoint:point3];
        
        [progressline closePath];
        
        _chartLine.path = progressline.CGPath;
        _chartLine.fillColor = [UIColor redColor].CGColor;
        _chartLine.strokeEnd = 1.0;
        
        
        CALayer *contentLayer = [CALayer layer];
        contentLayer.frame = self.bounds;
        contentLayer.mask = _chartLine;
        
        // 渐变色
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[XZColor clearColor].CGColor, (__bridge id)[XZColor colorWithRed:253.0/255.0 green:95.0/255.0 blue:93.0/255.0 alpha:0.15f].CGColor];
//        gradientLayer.colors = @[(__bridge id)[XZColor redColor].CGColor, (__bridge id)[XZColor colorWithRed:253.0/255.0 green:95.0/255.0 blue:93.0/255.0 alpha:0.15f].CGColor];
        gradientLayer.locations = @[@0.0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 1.0);
        gradientLayer.endPoint = CGPointMake(0, 0);
        gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        gradientLayer.masksToBounds = YES;
        
        [contentLayer addSublayer:gradientLayer];
        
        //        [contentLayer addSublayer:_chartLine];
        [self.layer addSublayer:contentLayer];
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
