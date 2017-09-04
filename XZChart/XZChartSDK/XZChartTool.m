//
//  XZChartTool.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZChartTool.h"

@implementation XZChartTool

// 通过Y轴数据获取Y轴坐标
+ (CGRange)getCoordinateWithYValue:(NSArray *)yValue
{
    float max = 0.00;
    float min = 1000000000.00;
    
    for (NSArray * ary in yValue) {
        for (NSString *valueString in ary) {
            float value = [valueString floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    float level = (max - min) / 4;
    
    if (max > 0 && min > 0 && level == 0) {
        
        max = max * 2;
        min = 0.00;
    }
    else
    {
        max = max + level;
        min = (min - level) < 0 ? 0 : (min - level);
    }
    
    return CGRangeMake(max, min);
}

// 获取NSInteger位数
+ (NSInteger)nsinterLength:(NSInteger)x
{
    NSInteger sum=0,j=1;
    while( x >= 1 ) {
        x=x/10;
        sum++;
        j=j*10;
    }
    return sum;
}

@end
