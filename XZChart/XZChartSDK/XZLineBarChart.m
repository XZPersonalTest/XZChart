//
//  XZLineBarChart.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZLineBarChart.h"

#include "XZChartLabel.h"

#import "XZChartTool.h"

@interface XZLineBarChart ()

// 坐标Y轴左侧最大和最小数值
@property (nonatomic) CGFloat yLeftValueMin;
@property (nonatomic) CGFloat yLeftValueMax;

// 坐标Y轴右侧最大和最小数值
@property (nonatomic) CGFloat yRightValueMin;
@property (nonatomic) CGFloat yRightValueMax;

// X坐标轴数值label宽度
@property (nonatomic) CGFloat xLabelWidth;

@end

@implementation XZLineBarChart{
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

// 折线数值  Y坐标
- (void)setLineChartValue:(NSArray *)lineChartValue
{
    _lineChartValue = lineChartValue;
    
    [self setYLeftAxis:lineChartValue];
    
    
}


// 设置Y轴左边坐标
- (void)setYLeftAxis:(NSArray *)yLeftAxis
{
    _yLeftAxis = yLeftAxis;
    
    CGRange range = [XZChartTool getCoordinateWithYValue:yLeftAxis];
    
    _yLeftValueMin = range.min;
    _yLeftValueMax = range.max;
    
    
    float level = (_yLeftValueMax-_yLeftValueMin) / 4.0;
    CGFloat chartCavanHeight = self.frame.size.height - XZLabelHeight * 4;
    CGFloat levelHeight = chartCavanHeight / 4.0;
    
    // Y轴坐标单位
    XZChartLabel *unitY = [[XZChartLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, XZYLabelwidth * 2, XZLabelHeight)];
    unitY.text = self.unitY;
    [self addSubview:unitY];
    
    // Y轴坐标
    for (int i = 0; i < 5; i++) {
        // 这里XZLabelHeight * 1.5 是为了让Y轴坐标上下与横线中心对齐
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(0.0 , chartCavanHeight - i * levelHeight + XZLabelHeight * 1.5, XZYLabelwidth, XZLabelHeight)];
        
        label.text = [NSString stringWithFormat:@"%.2f",(level * i + _yLeftValueMin)];
        [self addSubview:label];
    }
    
}

- (void)setBarChartValue:(NSArray *)barChartValue
{
    _barChartValue = barChartValue;
    
    [self setYRightAxis:barChartValue];
}

// 设置Y轴右边坐标
- (void)setYRightAxis:(NSArray *)yRightAxis
{
    _yRightAxis = yRightAxis;
    
    CGRange range = [XZChartTool getCoordinateWithYValue:yRightAxis];
    
    _yRightValueMin = range.min;
    _yRightValueMax = range.max;
    
    float level = (_yRightValueMax-_yRightValueMin) / 4.0;
    CGFloat chartCavanHeight = self.frame.size.height - XZLabelHeight * 4;
    CGFloat levelHeight = chartCavanHeight / 4.0;
    
    // Y轴坐标单位
    XZChartLabel *unitX = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - XZYLabelwidth * 2, 0.0, XZYLabelwidth * 2, XZLabelHeight)];
    unitX.text = self.unitX;
    [self addSubview:unitX];
    
    for (int i=0; i<5; i++) {
        // 这里XZLabelHeight * 1.5 是为了让Y轴坐标上下与横线中心对齐
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - XZYLabelwidth , chartCavanHeight - i * levelHeight + XZLabelHeight * 1.5, XZYLabelwidth, XZLabelHeight)];
        label.text = [NSString stringWithFormat:@"%d",(int)(level * i + _yRightValueMin)];
        [self addSubview:label];
    }
    
}

// 配置X轴坐标
- (void)setXAxis:(NSArray *)xAxis
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xAxis = xAxis;
    CGFloat num = 0;
    if (xAxis.count>=20) {
        num=20.0;
    }else if (xAxis.count<=1){
        num=1.0;
    }else{
        num = xAxis.count;
    }
    
    // X轴坐标label宽度
    _xLabelWidth = (self.frame.size.width - XZYLabelwidth * 2)/num;
    
    for (int i=0; i < xAxis.count; i++) {
        NSString *labelText = xAxis[i];
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth + XZYLabelwidth, self.frame.size.height - XZLabelHeight, _xLabelWidth, XZLabelHeight)];
        label.text = labelText;
        [self addSubview:label];
        
        [_chartLabelsForX addObject:label];
    }
    
}

// 折线颜色
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
}


// 显示网格横线
- (void)setIsShowHorizonLine:(BOOL)isShowHorizonLine
{
    _isShowHorizonLine = isShowHorizonLine;
    
//    float level = (_yLeftValueMax-_yLeftValueMin) /4.0;
    CGFloat chartCavanHeight = self.frame.size.height - XZLabelHeight * 4;
    CGFloat levelHeight = chartCavanHeight / 4.0;
    
    //画横线
    if (self.isShowHorizonLine) {
        
        for (int i=0; i<4; i++) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(XZYLabelwidth, XZLabelHeight * 2 + i * levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, XZLabelHeight * 2 + i * levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.lineWidth = 1;
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            [self.layer addSublayer:shapeLayer];
            
        }
        
    }
    
}

// 显示网格竖线
- (void)setIsShowVerticalLine:(BOOL)isShowVerticalLine
{
    _isShowVerticalLine = isShowVerticalLine;
    
    if (isShowVerticalLine) {
        //画网格横线
        for (int i = 0; i < self.xAxis.count + 1; i++) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(XZYLabelwidth+i*_xLabelWidth, XZLabelHeight * 2)];
            [path addLineToPoint:CGPointMake(XZYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*XZLabelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
    }
    
}


// 显示折线数值
- (void)setIsShowChartValue:(BOOL)isShowChartValue
{
    _isShowChartValue = isShowChartValue;
    
}

- (void)strokeChartLine
{
    
    // 画图标边框线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(XZYLabelwidth , XZLabelHeight * 2)];
    [path addLineToPoint:CGPointMake(XZYLabelwidth ,self.frame.size.height - 2 * XZLabelHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, self.frame.size.height - 2 * XZLabelHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, XZLabelHeight * 2)];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    shapeLayer.lineWidth = 2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:shapeLayer];
    
    for (int i=0; i < _lineChartValue.count; i++) {
        NSArray *childAry = _lineChartValue[i];
        if (childAry.count==0) {
            return;
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        
        
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (XZYLabelwidth + _xLabelWidth/2.0);
        // Y轴总高度
        CGFloat chartCavanHeight = self.frame.size.height - XZLabelHeight * 4;
        // 数值与高度比换算
        float grade = ((float)firstValue-_yLeftValueMin) / ((float)_yLeftValueMax-_yLeftValueMin);
        
        // 第一个点
        //  XZLabelHeight * 2是每个点要向下便宜的单位  XZLabelHeight为转折点数字label高度
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight + XZLabelHeight * 2)
                 index:i
                 value:firstValue];
        
        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight + XZLabelHeight * 2)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yLeftValueMin) / ((float)_yLeftValueMax-_yLeftValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight + XZLabelHeight * 2);
                [progressline addLineToPoint:point];
                
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                         value:[valueString floatValue]];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        // 线条颜色
        _chartLine.strokeColor = _lineColor ? _lineColor.CGColor : [XZColor redColor].CGColor;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
        
        
    }
}


-(void)strokeChartBar
{
    // 画柱形图  先把背景画出来
    for (int i=0; i<_barChartValue.count; i++) {
        
        if (i==2)
            return;
        NSArray *childAry = _barChartValue[i];
        for (int j=0; j<childAry.count; j++) {
            
            //划线
            CAShapeLayer *_chartLine = [CAShapeLayer layer];
            //            _chartLine.lineCap = kCALineCapRound;
            _chartLine.lineJoin = kCALineJoinBevel;
            _chartLine.fillColor   = [[UIColor greenColor] CGColor];
            _chartLine.lineWidth   = 15.0;
            _chartLine.strokeEnd   = 0.0;
            
            [self.layer addSublayer:_chartLine];
            
            UIBezierPath *progressline = [UIBezierPath bezierPath];
            [progressline setLineWidth: 15.0];
            [progressline setLineCapStyle:kCGLineCapSquare];
            [progressline setLineJoinStyle:kCGLineJoinRound];
            
            // 第一条柱形图point.X
            CGFloat xPosition = (XZYLabelwidth + _xLabelWidth/2.0);
            
            CGFloat yPosition = self.frame.size.height - XZLabelHeight * 2;
            
            [progressline moveToPoint:CGPointMake(xPosition + _xLabelWidth * j, yPosition - 1)];
            CGPoint point = CGPointMake(xPosition + _xLabelWidth * j, XZLabelHeight * 2);
            [progressline addLineToPoint:point];
            [progressline moveToPoint:point];
            
            _chartLine.path = progressline.CGPath;
            // 线条颜色
            _chartLine.strokeColor = [XZColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0].CGColor;
            
            //            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            //            pathAnimation.duration = childAry.count*0.4;
            //            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            //            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            //            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            //            pathAnimation.autoreverses = NO;
            //            [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            
            _chartLine.strokeEnd = 1.0;
            
        }
        
    }
    
    for (int i=0; i<_barChartValue.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _barChartValue[i];
        for (int j=0; j<childAry.count; j++) {
            
            // 数值与高度比换算
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            
            float grade = ((float)value-_yRightValueMin) / ((float)_yRightValueMax-_yRightValueMin);
            
            //划线
            CAShapeLayer *_chartLine = [CAShapeLayer layer];
            //                _chartLine.lineCap = kCALineCapRound;
            _chartLine.lineJoin = kCALineJoinBevel;
            _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
            _chartLine.lineWidth   = 15.0;
            _chartLine.strokeEnd   = 0.0;
            
            [self.layer addSublayer:_chartLine];
            
            UIBezierPath *progressline = [UIBezierPath bezierPath];
            [progressline setLineWidth:15.0];
            [progressline setLineCapStyle:kCGLineCapRound];
            [progressline setLineJoinStyle:kCGLineJoinRound];
            
            // Y轴总高度
            CGFloat chartCavanHeight = self.frame.size.height - XZLabelHeight * 4;
            
            CGFloat xPosition = (XZYLabelwidth + _xLabelWidth/2.0);
            CGFloat yPosition = self.frame.size.height - XZLabelHeight * 2;
            
            [progressline moveToPoint:CGPointMake(xPosition + _xLabelWidth * j, yPosition - 1)];
            
            CGPoint point = CGPointMake(xPosition + _xLabelWidth * j, chartCavanHeight - grade * chartCavanHeight + XZLabelHeight * 2);
            [progressline addLineToPoint:point];
            [progressline moveToPoint:point];
            
            _chartLine.path = progressline.CGPath;
            // 线条颜色
            _chartLine.strokeColor = [XZColor greenColor].CGColor;
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = childAry.count*0.4;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            pathAnimation.autoreverses = NO;
            [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            
            _chartLine.strokeEnd = 1.0;
            
        }
    }
}



- (void)addPoint:(CGPoint)point index:(NSInteger)index value:(CGFloat)value
{
    
    // 折线转折点
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(7, 7, 4, 4)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2;
    view.backgroundColor = _lineColor ? _lineColor : [XZColor redColor];
    
    if (_isShowChartValue) {
        
        // 转折点数值
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-XZTagLabelwidth/2.0, point.y-XZLabelHeight*2, XZTagLabelwidth, XZLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%.2f",value];
        
        [self addSubview:label];
        
    }
    
    [self addSubview:view];
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
