//
//  XZChartTool.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZChartConst.h"

@interface XZChartTool : NSObject


// 通过Y轴数据获取Y轴坐标
+ (CGRange)getCoordinateWithYValue:(NSArray *)yValue;


@end
