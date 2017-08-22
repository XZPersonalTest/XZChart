//
//  XZBarChart.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZBarChart : UIView

// 图标区域总高度
@property (nonatomic) CGFloat chartHeight;

// X轴坐标数组
@property (strong,nonatomic) NSArray *xAxis;

// 左侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yLeftAxis;
// 右侧Y轴坐标数组
@property (strong,nonatomic) NSArray *yRightAxis;

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

// 柱形图颜色
@property (strong,nonatomic) NSArray <UIColor *> *barColors;
// 柱形图背景色
@property (strong,nonatomic) NSArray <UIColor *> *barBgColors;

/** 是否显示网格横线 */
@property (assign,nonatomic) BOOL isShowHorizonLine;

/** 是否显示网格竖线 */
@property (assign,nonatomic) BOOL isShowVerticalLine;

/** 是否显示柱形图数据数值 */
@property (assign,nonatomic) BOOL isShowBarValue;


// 绘制柱状图
- (void)strokeChartBar;

- (NSArray *)chartLabelsForX;

@end
