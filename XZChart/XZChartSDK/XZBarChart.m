//
//  XZBarChart.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZBarChart.h"

#include "XZChartLabel.h"

#import "XZChartTool.h"

@interface XZBarChart ()

// 图标区域总高度
@property (nonatomic) CGFloat chartCavanHeight;
// 图标区域每行高度
@property (nonatomic) CGFloat levelHeight;
// Y轴最低位置Y坐标
@property (nonatomic) CGFloat yPosition;

// 坐标Y轴左侧最大和最小数值
@property (nonatomic) CGFloat yLeftValueMin;
@property (nonatomic) CGFloat yLeftValueMax;

// 坐标Y轴右侧最大和最小数值
@property (nonatomic) CGFloat yRightValueMin;
@property (nonatomic) CGFloat yRightValueMax;

// X坐标轴数值label宽度
@property (nonatomic) CGFloat xLabelWidth;

@end
@implementation XZBarChart{
    NSHashTable *_chartLabelsForX;
}

#pragma mark - lazy
- (CGFloat)chartCavanHeight
{
    if (!_chartCavanHeight) {
        CGFloat chartCavanHeight = self.chartHeight - XZLabelHeight * 4 - XZBottomMargin;
        _chartCavanHeight = chartCavanHeight;
    }
    return _chartCavanHeight;
}

- (CGFloat)levelHeight
{
    if (!_levelHeight) {
        CGFloat levelHeight = self.chartCavanHeight / 4.0;
        _levelHeight = levelHeight;
    }
    return _levelHeight;
}

- (CGFloat)yPosition
{
    if (!_yPosition) {
        CGFloat yPosition = self.chartCavanHeight + 2 * XZLabelHeight;
        _yPosition = yPosition;
    }
    return _yPosition;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}


#pragma mark - 配置Y坐标
// 柱形图数据数组   根据数据计算Y轴左右侧坐标  第一个数组为左侧坐标数据   第二个数组为右侧坐标数据
- (void)setBarChartValue:(NSArray *)barChartValue
{
    _barChartValue = barChartValue;
    
    // 计算左侧Y坐标
    [self setYLeftAxis:@[[barChartValue firstObject]]];
    
    // 计算右侧Y坐标
    [self setYRightAxis:@[[barChartValue lastObject]]];
}


// 设置Y轴左边坐标
- (void)setYLeftAxis:(NSArray *)yLeftAxis
{
    _yLeftAxis = yLeftAxis;
    
    CGRange range = [XZChartTool getCoordinateWithYValue:yLeftAxis];
    
    _yLeftValueMin = range.min;
    _yLeftValueMax = range.max;
    
    
    float level = (_yLeftValueMax-_yLeftValueMin) / 4.0;
    
    // Y轴坐标单位
    XZChartLabel *unitY = [[XZChartLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, XZYLabelwidth * 2, XZLabelHeight)];
    unitY.text = self.unitLeftY;
    [self addSubview:unitY];
    
    // Y轴坐标
    for (int i = 0; i < 5; i++) {
        // 这里XZLabelHeight * 1.5 是为了让Y轴坐标上下与横线中心对齐
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(0.0 , self.chartCavanHeight - i * self.levelHeight + XZLabelHeight * 1.5, XZYLabelwidth, XZLabelHeight)];
        
        label.text = [NSString stringWithFormat:@"%.2f",(level * i + _yLeftValueMin)];
        [self addSubview:label];
    }
    
}

// 设置Y轴右边坐标
- (void)setYRightAxis:(NSArray *)yRightAxis
{
    _yRightAxis = yRightAxis;
    
    CGRange range = [XZChartTool getCoordinateWithYValue:yRightAxis];
    
    _yRightValueMin = range.min;
    _yRightValueMax = range.max;
    
    float level = (_yRightValueMax-_yRightValueMin) / 4.0;
    
    // Y轴坐标单位
    XZChartLabel *unitX = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - XZYLabelwidth * 2, 0.0, XZYLabelwidth * 2, XZLabelHeight)];
    unitX.text = self.unitRightY;
    [self addSubview:unitX];
    
    for (int i=0; i<5; i++) {
        // 这里XZLabelHeight * 1.5 是为了让Y轴坐标上下与横线中心对齐
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - XZYLabelwidth , self.chartCavanHeight - i * self.levelHeight + XZLabelHeight * 1.5, XZYLabelwidth, XZLabelHeight)];
        label.text = [NSString stringWithFormat:@"%d",(int)(level * i + _yRightValueMin)];
        [self addSubview:label];
    }
    
}

#pragma mark - 配置X坐标
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
    _xLabelWidth = (self.frame.size.width - XZYLabelwidth * 2 - 20)/num;
    
    for (int i=0; i < xAxis.count; i++) {
        NSString *labelText = xAxis[i];
        XZChartLabel * label = [[XZChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth + XZYLabelwidth + 10, self.yPosition + XZLabelHeight, _xLabelWidth, XZLabelHeight)];
        label.text = labelText;
        [self addSubview:label];
        
        [_chartLabelsForX addObject:label];
    }
    
}

// 柱形图颜色
- (void)setBarColors:(NSArray<UIColor *> *)barColors
{
    _barColors = barColors;
}

// 柱形图背景色
- (void)setBarBgColors:(NSArray<UIColor *> *)barBgColors
{
    _barBgColors = barBgColors;
}


// 显示网格横线
- (void)setIsShowHorizonLine:(BOOL)isShowHorizonLine
{
    _isShowHorizonLine = isShowHorizonLine;
    
    //画横线
    if (self.isShowHorizonLine) {
        
        for (int i=0; i<4; i++) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(XZYLabelwidth, XZLabelHeight * 2 + i * self.levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, XZLabelHeight * 2 + i * self.levelHeight)];
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


// 是否显示数据数值
- (void)setIsShowBarValue:(BOOL)isShowBarValue
{
    _isShowBarValue = isShowBarValue;
    
}

#pragma mark - 开始画线了
-(void)strokeChartBar
{
    
    // 画图标边框线
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(XZYLabelwidth , XZLabelHeight * 2)];
    [path addLineToPoint:CGPointMake(XZYLabelwidth ,self.chartCavanHeight + 2 * XZLabelHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, self.chartCavanHeight + 2 * XZLabelHeight)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - XZYLabelwidth, XZLabelHeight * 2)];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    shapeLayer.lineWidth = 2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:shapeLayer];
    
    
    // 画柱形图  先把背景画出来
    for (int i=0; i<_barChartValue.count; i++) {
        
        if (i==2)
            return;
        NSArray *childAry = _barChartValue[i];
        for (int j=0; j<childAry.count; j++) {
            
            //划线
            CAShapeLayer *_chartLine = [CAShapeLayer layer];
            _chartLine.lineJoin = kCALineJoinBevel;
            _chartLine.fillColor   = [[UIColor greenColor] CGColor];
            _chartLine.lineWidth   = 13.0;
            _chartLine.strokeEnd   = 0.0;
            
            [self.layer addSublayer:_chartLine];
            
            UIBezierPath *progressline = [UIBezierPath bezierPath];
            [progressline setLineCapStyle:kCGLineCapSquare];
            [progressline setLineJoinStyle:kCGLineJoinRound];
            
            // 第一条柱形图point.X
            CGFloat xPosition = XZYLabelwidth + _xLabelWidth/2.0;
            
            if (_barChartValue.count == 2) {
                // 第一个值最后的减10为减掉向左的偏移量   第二个值最后的加10为加上向右的偏移量
                xPosition = i == 0 ? XZYLabelwidth + _xLabelWidth/2.0 + 10 - 7: XZYLabelwidth + _xLabelWidth/2.0 + 10 + 7;
            }
            
            
            [progressline moveToPoint:CGPointMake(xPosition + _xLabelWidth * j, self.yPosition - 1)];
            CGPoint point = CGPointMake(xPosition + _xLabelWidth * j, XZLabelHeight * 2);
            [progressline addLineToPoint:point];
            [progressline moveToPoint:point];
            
            _chartLine.path = progressline.CGPath;
            
            // 柱形图背景颜色
            _chartLine.strokeColor = _barBgColors.count ? _barChartValue.count == _barBgColors.count ? _barBgColors[i].CGColor : [XZColor gray].CGColor : [XZColor gray].CGColor;
            
            _chartLine.strokeEnd = 1.0;
            
        }
        
    }
    
    for (int i=0; i<_barChartValue.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _barChartValue[i];
        
        UIColor *color = _barColors.count ? _barChartValue.count == _barColors.count ?  _barColors[i] : [XZColor green] : [XZColor green];
        
        for (int j=0; j<childAry.count; j++) {
            
            // 数值与高度比换算
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            
            float grade = ((float)value-_yRightValueMin) / ((float)_yRightValueMax-_yRightValueMin);
            
            //划线
            CAShapeLayer *_chartLine = [CAShapeLayer layer];
            _chartLine.lineJoin = kCALineJoinBevel;
            _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
            _chartLine.lineWidth   = 13.0;
            _chartLine.strokeEnd   = 0.0;
            
            [self.layer addSublayer:_chartLine];
            
            UIBezierPath *progressline = [UIBezierPath bezierPath];
            [progressline setLineCapStyle:kCGLineCapRound];
            [progressline setLineJoinStyle:kCGLineJoinRound];
            
            CGFloat xPosition = XZYLabelwidth + _xLabelWidth/2.0;
            
            if (_barChartValue.count == 2) {
                // 第一个值最后的减10为减掉向左的偏移量   第二个值最后的加10为加上向右的偏移量
                xPosition = i == 0 ? XZYLabelwidth + _xLabelWidth/2.0 + 10 - 7: XZYLabelwidth + _xLabelWidth/2.0 + 10 + 7;
            }
            
            [progressline moveToPoint:CGPointMake(xPosition + _xLabelWidth * j, self.yPosition - 1)];
            
            CGPoint point = CGPointMake(xPosition + _xLabelWidth * j, self.chartCavanHeight - grade * self.chartCavanHeight + XZLabelHeight * 2);
            [progressline addLineToPoint:point];
            [progressline moveToPoint:point];
            
            _chartLine.path = progressline.CGPath;
            
            // 柱形图颜色
            _chartLine.strokeColor = color.CGColor;
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = childAry.count*0.4;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            pathAnimation.autoreverses = NO;
            [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
            
            _chartLine.strokeEnd = 1.0;
            
        }
        
        [self configChartMarkIndex:i color:color];
    }
}



#pragma mark - 图表标注
- (void)configChartMarkIndex:(NSInteger)index color:(UIColor *)color
{
    
    //划线
    CAShapeLayer *_chartLine = [CAShapeLayer layer];
    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth   = 13.0;
    _chartLine.strokeEnd   = 0.0;
    
    [self.layer addSublayer:_chartLine];
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline setLineCapStyle:kCGLineCapRound];
    [progressline setLineJoinStyle:kCGLineJoinRound];
    
    [progressline moveToPoint:CGPointMake(self.frame.size.width - (55 + index * 70), self.frame.size.height - 30)];
    
    CGPoint point = CGPointMake(self.frame.size.width - (42 + index * 70), self.frame.size.height - 30);
    [progressline addLineToPoint:point];
    [progressline moveToPoint:point];
    
    _chartLine.path = progressline.CGPath;
    // 柱形图颜色
    _chartLine.strokeColor = color.CGColor;
    
    _chartLine.strokeEnd = 1.0;
    
    
    XZChartLabel *lineMarkLabel = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - (40 + index * 70), self.frame.size.height - 35, 40, 10)];
    lineMarkLabel.font = [UIFont systemFontOfSize:12];
    lineMarkLabel.text = self.markArr[index];
    [self addSubview:lineMarkLabel];
    
    
}




#pragma mark - 显示柱形图数据数值
// 显示详细数据数值
//- (void)addPoint:(CGPoint)point index:(NSInteger)index value:(CGFloat)value
//{
//    
//    // 折线转折点
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(7, 7, 4, 4)];
//    view.center = point;
//    view.layer.masksToBounds = YES;
//    view.layer.cornerRadius = 2;
//    view.backgroundColor = _lineColors.count ? _lineColors[index] : [XZColor redColor];
//    
//    if (_isShowChartValue) {
//        
//        // 转折点数值
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-XZTagLabelwidth/2.0, point.y-XZLabelHeight*2, XZTagLabelwidth, XZLabelHeight)];
//        label.font = [UIFont systemFontOfSize:10];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = view.backgroundColor;
//        label.text = [NSString stringWithFormat:@"%.2f",value];
//        
//        [self addSubview:label];
//        
//    }
//    
//    [self addSubview:view];
//}


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
