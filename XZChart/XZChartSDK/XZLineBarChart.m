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

#import "XZSpaceView.h"

@interface XZLineBarChart ()

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

/** 画折线图间隙渐变色时使用的左上角坐标 */
@property (assign,nonatomic) CGPoint firstPoint;

@end

@implementation XZLineBarChart{
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

// 折线数值   根据数据计算左侧Y坐标
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


// 柱形图数据  根据数据计算右侧Y坐标
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

// 折线颜色
- (void)setLineColors:(NSArray<UIColor *> *)lineColors
{
    _lineColors = lineColors;
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
        
        for (int i=0; i < self.yLeftAxis.count - 1; i++) {
            
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


// 显示折线数值
- (void)setIsShowLineValue:(BOOL)isShowLineValue
{
    _isShowLineValue = isShowLineValue;
}

// 显示柱形图数值
- (void)setIsShowBarValue:(BOOL)isShowBarValue
{
    _isShowBarValue = isShowBarValue;
}


#pragma mark - 开始画线
// 则线图
- (void)strokeChartLine
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
        _chartLine.lineWidth   = 0.7;
        _chartLine.strokeEnd   = 0.0;
        
        
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = XZYLabelwidth + _xLabelWidth/2.0 + 10;
        // 数值与高度比换算
        float grade = _yLeftValueMax - _yLeftValueMin <= 0 ? 0 : (firstValue-_yLeftValueMin) / (_yLeftValueMax-_yLeftValueMin);
        
        // 第一个点
        //  XZLabelHeight * 2是每个点要向下便宜的单位  XZLabelHeight为转折点数字label高度
        [self addPoint:CGPointMake(xPosition, self.chartCavanHeight - grade * self.chartCavanHeight + XZLabelHeight * 2)
                 index:i
                 value:firstValue];
        
        CGPoint point = CGPointMake(xPosition, self.chartCavanHeight - grade * self.chartCavanHeight + XZLabelHeight * 2);
        
        [progressline moveToPoint:point];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade = _yLeftValueMax - _yLeftValueMin <= 0 ? 0 : ([valueString floatValue]-_yLeftValueMin) / ((float)_yLeftValueMax-_yLeftValueMin);
            
            if (index != 0) {
                
                self.firstPoint = point;
                point = CGPointMake(xPosition+index*_xLabelWidth, self.chartCavanHeight - grade * self.chartCavanHeight + XZLabelHeight * 2);
                [progressline addLineToPoint:point];
                
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                         value:[valueString floatValue]];
                
                // 间隙渐变色
                [self configSpaceGradientWithSecondPoint:point];
                
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        // 线条颜色
        UIColor * color = _lineColors.count ? _lineColors.count == _lineChartValue.count ? _barBgColors[i] : [XZColor redColor] : [XZColor redColor];
        _chartLine.strokeColor = color.CGColor;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
        
        
        [self configChartMarkIsLineChart:YES color:color index:-1];
    }
    
    
}

// 柱形图
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
            _chartLine.lineJoin = kCALineJoinBevel;
            _chartLine.fillColor   = [[UIColor greenColor] CGColor];
            _chartLine.lineWidth   = 13.0;
            _chartLine.strokeEnd   = 0.0;
            
            [self.layer addSublayer:_chartLine];
            
            UIBezierPath *progressline = [UIBezierPath bezierPath];
            [progressline setLineCapStyle:kCGLineCapSquare];
            [progressline setLineJoinStyle:kCGLineJoinRound];
            
            // 第一条柱形图point.X
            CGFloat xPosition = XZYLabelwidth + _xLabelWidth/2.0 + 10;
            if (_barChartValue.count == 2) {
                // 第一个值最后的减10为减掉向左的偏移量   第二个值最后的加10为加上向右的偏移量
                xPosition = i == 0 ? XZYLabelwidth + _xLabelWidth/2.0 + 10 - 7 : XZYLabelwidth + _xLabelWidth/2.0 + 10 + 7;
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
            
            float grade = _yRightValueMax - _yRightValueMin <= 0 ? 0 : ((float)value-_yRightValueMin) / ((float)_yRightValueMax-_yRightValueMin);
            
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
            
            // X位置坐标
            CGFloat xPosition = XZYLabelwidth + _xLabelWidth / 2.0 + 10;
            if (_barChartValue.count == 2) {
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
        
        [self configChartMarkIsLineChart:NO color:color index:i];
    }
    
}


#pragma mark - 图表标注
- (void)configChartMarkIsLineChart:(BOOL)isLineChart color:(UIColor *)color index:(NSInteger)index
{
    if (isLineChart) {
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 0.7;
        _chartLine.strokeEnd   = 0.0;
        
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        
        [progressline moveToPoint:CGPointMake(self.frame.size.width - 55, self.frame.size.height - 30)];
        
        CGPoint point = CGPointMake(self.frame.size.width - 35, self.frame.size.height - 30);
        [progressline addLineToPoint:point];
        [progressline moveToPoint:point];
        
        _chartLine.path = progressline.CGPath;
        // 柱形图颜色
        _chartLine.strokeColor = color.CGColor;
        
        _chartLine.strokeEnd = 1.0;
        
        // 折线转折点
        UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 4)];
        dotView.center = CGPointMake(point.x - 10, point.y);
        dotView.layer.masksToBounds = YES;
        dotView.layer.cornerRadius = 2;
        dotView.backgroundColor = color;
        [self addSubview:dotView];
        
        XZChartLabel *lineMarkLabel = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 35, self.frame.size.height - 35, 35, 10)];
        lineMarkLabel.font = [UIFont systemFontOfSize:12];
        lineMarkLabel.text = [self.markArr lastObject];
        [self addSubview:lineMarkLabel];
        
    }
    else
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
        
        [progressline moveToPoint:CGPointMake(self.frame.size.width - (128 + index * 70), self.frame.size.height - 30)];
        
        CGPoint point = CGPointMake(self.frame.size.width - (115 + index * 70), self.frame.size.height - 30);
        [progressline addLineToPoint:point];
        [progressline moveToPoint:point];
        
        _chartLine.path = progressline.CGPath;
        // 柱形图颜色
        _chartLine.strokeColor = color.CGColor;
        
        _chartLine.strokeEnd = 1.0;
        
        
        XZChartLabel *barMarkLabel = [[XZChartLabel alloc] initWithFrame:CGRectMake(self.frame.size.width - (110 + index * 70), self.frame.size.height - 35, 40, 10)];
        barMarkLabel.font = [UIFont systemFontOfSize:12];
        barMarkLabel.text = self.markArr[index];
        barMarkLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:barMarkLabel];
        
        
    }
}


#pragma mark - 显示数值
// 显示折线数值
- (void)addPoint:(CGPoint)point index:(NSInteger)index value:(CGFloat)value
{
    
    // 折线转折点
    UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(7, 7, 3, 3)];
    dotView.center = point;
    dotView.layer.masksToBounds = YES;
    dotView.layer.cornerRadius = 1.5;
    dotView.backgroundColor = _lineColors.count ? _lineColors[index] : [XZColor redColor];
    
    if (_isShowLineValue) {
        
        // 转折点数值
        XZChartLabel *label = [[XZChartLabel alloc]initWithFrame:CGRectMake(point.x-XZTagLabelwidth/2.0, point.y-XZLabelHeight*2, XZTagLabelwidth, XZLabelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [XZColor red];
        label.text = [NSString stringWithFormat:@"%.2f",value];
        
        [self addSubview:label];
        
    }
    
    [self addSubview:dotView];
}


// 配置折线图间隙渐变色
- (void)configSpaceGradientWithSecondPoint:(CGPoint)secondPoint
{
    
    CGFloat Y = self.firstPoint.y < secondPoint.y ? self.firstPoint.y : secondPoint.y;
    
    // 将父View的点坐标换算到渐变的View上
    CGPoint firstPoint = CGPointMake(0, self.firstPoint.y > secondPoint.y ? self.firstPoint.y - secondPoint.y : 0);
    
    secondPoint = CGPointMake(fabs(secondPoint.x - self.firstPoint.x), self.firstPoint.y > secondPoint.y ? 0 : secondPoint.y - self.firstPoint.y);
    
    XZSpaceView *spaceView = [[XZSpaceView alloc] initWithFrame:CGRectMake(self.firstPoint.x, Y, fabs(secondPoint.x - firstPoint.x), fabs(self.yPosition - Y)) firstPoint:firstPoint secondPoint:secondPoint];
    
    [self addSubview:spaceView];
}


- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}



@end
