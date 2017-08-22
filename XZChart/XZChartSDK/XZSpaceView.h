//
//  XZSpaceView.h
//  XZChart
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZSpaceView : UIView


/**
 柱状图间隙渐变色
 
 @param frame 间隙frame
 @param firstPoint 左上角不确定点坐标
 @param secondPoint 右上角不确定点坐标
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame firstPoint:(CGPoint)firstPoint secondPoint:(CGPoint)secondPoint;

@end
