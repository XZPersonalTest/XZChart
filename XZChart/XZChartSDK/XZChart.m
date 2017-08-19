//
//  XZChart.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZChart.h"

@interface XZChart ()

// 图形View
@property (strong,nonatomic) XZLineBarChart *lineBarView;


@end

@implementation XZChart

// 创建
- (id)initWithFrame:(CGRect)rect style:(XZChartStyle)style
{
    self.chartStyle = style;
    return [self initWithFrame:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)setUpChart{
    
    
    switch (self.chartStyle) {
        case XZChartStyleLine:
        {
            
            
        }
            break;
        case XZChartStyleBar:
        {
//            if (!_barChart) {
//                _barChart = [[XZBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//                [self addSubview:_barChart];
//            }
//            if ([self.dataSource respondsToSelector:@selector(chartLeftRange:)]) {
//                [_barChart setLeftChooseRange:[self.dataSource chartLeftRange:self]];
//            }
//            if ([self.dataSource respondsToSelector:@selector(chartConfigColors:)]) {
//                [_barChart setColors:[self.dataSource chartConfigColors:self]];
//            }
//            [_barChart setYValues:[self.dataSource chartConfigAxisYValue:self]];
//            [_barChart setXLabels:[self.dataSource chartConfigAxisXLabel:self]];
//            
//            [_barChart strokeChart];
            
        }
            break;
        case XZChartStyleLineAndBar:
        {
            if(!_lineBarView){
                _lineBarView = [[XZLineBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [self addSubview:_lineBarView];
            }
            
            // X轴坐标
            _lineBarView.xAxis = self.xAxis;
            // 折线数据
            _lineBarView.lineChartValue = self.lineChartValue;
            // 柱形图数据
            _lineBarView.barChartValue = self.barChartValue;
            // X轴坐标单位
            _lineBarView.unitX = self.unitX;
            // Y轴坐标单位
            _lineBarView.unitY = self.unitY;
            // 折线颜色
            _lineBarView.lineColor = self.lineColor;
            // 转折点数值
            _lineBarView.isShowChartValue = YES;
            // 显示网格横线
            _lineBarView.isShowHorizonLine = self.isShowHorizonLine;

            [_lineBarView strokeChartBar];
            
            [_lineBarView strokeChartLine];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)showInView:(UIView *)view
{
    [self setUpChart];
    [view addSubview:self];
}

-(void)strokeChart
{
    [self setUpChart];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
