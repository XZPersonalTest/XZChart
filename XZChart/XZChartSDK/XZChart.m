//
//  XZChart.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZChart.h"

@interface XZChart ()

// 折线图+柱状图 图形View
@property (strong,nonatomic) XZLineBarChart *lineBarView;

// 折线图 图形View
@property (strong,nonatomic) XZLineChart *lineView;

// 柱状图 图形View
@property (strong,nonatomic) XZBarChart *barView;



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
            if (!_barView) {
                _barView = [[XZBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [self addSubview:_barView];
            }
            // 图表总高度
            _barView.chartHeight = 200;
            // X轴坐标
            _barView.xAxis = self.xAxis;
            // X轴坐标单位
            _barView.unitX = self.unitX;
            // 左侧Y轴坐标单位
            _barView.unitLeftY = self.unitLeftY;
            // 右侧Y轴坐标单位
            _barView.unitRightY = self.unitRightY;
            // 底部图标标注
            _barView.markArr = self.markArr;
            // 柱形图数据
            _barView.barChartValue = self.barChartValue;
            // 柱形图颜色
            _barView.barColors = self.barColors;
            // 柱形图背景色
            _barView.barBgColors = self.barBgColors;
            // 柱形图数据数值
            _barView.isShowBarValue = self.isShowBarValue;
            // 显示网格横线
            _barView.isShowHorizonLine = self.isShowHorizonLine;
            
            [_barView strokeChartBar];
            
            
        }
            break;
        case XZChartStyleLineAndBar:
        {
            if(!_lineBarView){
                _lineBarView = [[XZLineBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [self addSubview:_lineBarView];
            }
            // 图表总高度
            _lineBarView.chartHeight = 200;
            // X轴坐标
            _lineBarView.xAxis = self.xAxis;
            // X轴坐标单位
            _lineBarView.unitX = self.unitX;
            // 左侧Y轴坐标单位
            _lineBarView.unitLeftY = self.unitLeftY;
            // 右侧Y轴坐标单位
            _lineBarView.unitRightY = self.unitRightY;
            // 底部图标标注
            _lineBarView.markArr = self.markArr;
            // 折线数据
            _lineBarView.lineChartValue = self.lineChartValue;
            // 柱形图数据
            _lineBarView.barChartValue = self.barChartValue;
            // 折线颜色
            _lineBarView.lineColors = self.lineColors;
            // 柱形图颜色
            _lineBarView.barColors = self.barColors;
            // 柱形图背景色
            _lineBarView.barBgColors = self.barBgColors;
            // 转折点数值
            _lineBarView.isShowLineValue = self.isShowLineValue;
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
