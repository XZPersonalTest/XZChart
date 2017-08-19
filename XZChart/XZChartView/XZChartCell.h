//
//  XZChartCell.h
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZChartCell : UITableViewCell

- (void)configUI:(NSIndexPath *)indexPath;

/** 图形类型 */
@property (assign,nonatomic) NSInteger chartType;

@end
