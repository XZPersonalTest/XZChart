//
//  XZChartConst.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>


// 转折点数字label高度 
#define XZLabelHeight       10
// Y轴左右两边左边值label宽度
#define XZYLabelwidth       30
// 折线数值Label宽度
#define XZTagLabelwidth     80

// 底部边距
#define XZBottomMargin      50

typedef NS_ENUM(NSInteger, XZChartStyle) {
    
    XZChartStyleLine            = 0, // 折线图
    XZChartStyleBar             = 1, // 柱形图
    XZChartStyleLineAndBar      = 2, // 折线图+柱形图
    
};


@interface XZChartConst : NSObject

@end

//范围
struct Range {
    CGFloat max;
    CGFloat min;
};
typedef struct Range CGRange;
CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange
CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0,0};


@interface XZColor : UIColor

+ (UIColor *)randomColor;
+ (UIColor *)randomColorDeep;
+ (UIColor *)randomColorlight;
+ (UIColor *)red;
+ (UIColor *)green;
+ (UIColor *)brown;
+ (UIColor *)gray;

@end
