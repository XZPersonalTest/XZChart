//
//  XZChart.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZLineBarChart.h"
#import "XZLineChart.h"
#import "XZBarChart.h"

#import "XZChartConst.h"


@interface XZChart : UIView

/** 图形模式 */
@property (assign,nonatomic) XZChartStyle chartStyle;

// X轴坐标数组
@property (strong,nonatomic) NSArray *xAxis;

// FIXME:如果此处的Y轴坐标不传值,则Y轴坐标会根据传入的数据进行智能分配
// 左侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yLeftAxis;
// 右侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yRightAxis;

// 折线图数据数组 数组里套数组 可一次传递多组数据
@property (strong,nonatomic) NSArray <NSArray *>*lineChartValue;

// 柱形图数据数组 数组里套数组 可一次传递多组数据
@property (strong,nonatomic) NSArray <NSArray *>*barChartValue;

// 左侧Y轴坐标单位
@property (strong,nonatomic) NSString *unitLeftY;
// 右侧Y轴坐标单位
@property (strong,nonatomic) NSString *unitRightY;
// X轴坐标单位
@property (strong,nonatomic) NSString *unitX;

/** 图标底部标注 */
@property(nonatomic,strong)NSArray *markArr;

// 折线图线条颜色
@property (strong,nonatomic) NSArray <UIColor *> *lineColors;
// 柱形图颜色
@property (strong,nonatomic) NSArray <UIColor *> *barColors;
// 柱形图背景色
@property (strong,nonatomic) NSArray <UIColor *> *barBgColors;

/** 是否显示横线 */
@property (assign,nonatomic) BOOL isShowHorizonLine;

/** 是否显示竖线 */
@property (assign,nonatomic) BOOL isShowVerticalLine;

/** 是否显示折线图数据数值 */
@property (assign,nonatomic) BOOL isShowLineValue;

/** 是否显示柱形图数据数值 */
@property (assign,nonatomic) BOOL isShowBarValue;

// 创建
- (id)initWithFrame:(CGRect)rect style:(XZChartStyle)style;


/**
 显示到某个View上

 @param view 自定一个的View
 */
- (void)showInView:(UIView *)view;

// 开始画图了
- (void)strokeChart;




@end
