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

// 图标区域总高度
@property (nonatomic) CGFloat chartHeight;

// X轴坐标数组
@property (strong,nonatomic) NSArray *xAxis;

// 左侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yLeftAxis;
// 右侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yRightAxis;

// 折线图数据数组
@property (strong,nonatomic) NSArray <NSArray *>* lineChartValue;

// 柱形图数据数组
@property (strong,nonatomic) NSArray <NSArray *>*barChartValue;

// 左侧Y轴坐标单位
@property (strong,nonatomic) NSString *unitLeftY;
// 右侧Y轴坐标单位
@property (strong,nonatomic) NSString *unitRightY;
// X轴坐标单位
@property (strong,nonatomic) NSString *unitX;

/** 图表底部标注文字 */
@property(nonatomic,strong)NSArray *markArr;

// 折线图线条颜色
@property (strong,nonatomic) NSArray <UIColor *> *lineColors;
// 柱形图颜色
@property (strong,nonatomic) NSArray <UIColor *> *barColors;
// 柱形图背景色
@property (strong,nonatomic) NSArray <UIColor *> *barBgColors;

/** 是否显示网格横线 */
@property (assign,nonatomic) BOOL isShowHorizonLine;

/** 是否显示网格竖线 */
@property (assign,nonatomic) BOOL isShowVerticalLine;

/** 是否显示折线图数据数值 */
@property (assign,nonatomic) BOOL isShowLineValue;

/** 是否显示柱形图数据数值 */
@property (assign,nonatomic) BOOL isShowBarValue;


// 绘制则线图
- (void)strokeChartLine;

// 绘制柱状图
- (void)strokeChartBar;

- (NSArray *)chartLabelsForX;

@end
