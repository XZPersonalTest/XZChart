//
//  XZLineBarChart.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZChartConst.h"

@interface XZLineBarChart : UIView

// X轴坐标数组
@property (strong,nonatomic) NSArray *xAxis;

// 左侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yLeftAxis;
// 右侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yRightAxis;

// 折线图数据数组
@property (strong,nonatomic) NSArray *lineChartValue;

// 柱形图数据数组
@property (strong,nonatomic) NSArray *barChartValue;

// Y轴坐标单位
@property (strong,nonatomic) NSString *unitY;
// X轴坐标单位
@property (strong,nonatomic) NSString *unitX;

// 折线图线条颜色
@property (strong,nonatomic) UIColor *lineColor;

/** 是否显示网格横线 */
@property (assign,nonatomic) BOOL isShowHorizonLine;

/** 是否显示网格竖线 */
@property (assign,nonatomic) BOOL isShowVerticalLine;

/** 是否显示数据数值 */
@property (assign,nonatomic) BOOL isShowChartValue;


// 绘制则线图
- (void)strokeChartLine;

// 绘制柱状图
- (void)strokeChartBar;

- (NSArray *)chartLabelsForX;

@end
