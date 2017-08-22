//
//  XZChartConst.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZChartConst.h"

@implementation XZChartConst

@end



@implementation XZColor

+ (UIColor *)randomColor
{
    return [self colorWithRed:arc4random()%255/255.0
                        green:arc4random()%255/255.0
                         blue:arc4random()%255/255.0
                        alpha:1.0f];
}

+ (UIColor *)randomColorDeep
{
    return [UIColor colorWithRed:(arc4random()%100 + 55)/255.0
                           green:(arc4random()%100 + 55)/255.0
                            blue:(arc4random()%100 + 55)/255.0
                           alpha:1.0f];
}

+ (UIColor *)randomColorlight
{
    return [UIColor colorWithRed:(arc4random()%100 + 155)/255.0
                           green:(arc4random()%100 + 155)/255.0
                            blue:(arc4random()%100 + 155)/255.0
                           alpha:1.0f];
}

+ (UIColor *)red
{
    return [UIColor colorWithRed:253/255.0 green:95/255.0 blue:93/255.0 alpha:1.0];
}

+ (UIColor *)green
{
    return [UIColor colorWithRed:66/255.0 green:204/255.0 blue:158/255.0 alpha:1.0];
}

+ (UIColor *)brown
{
    return [UIColor colorWithRed:119.0/255.0 green:107.0/255.0 blue:95.0/255.0 alpha:1.0f];
}

+ (UIColor *)gray
{
    return [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
}

+ (CGFloat)getRandomByNum:(int)num {
    
    return (arc4random()%num + 100)/255.0;
}

@end




