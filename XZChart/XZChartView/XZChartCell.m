//
//  XZChartCell.m
//  XZChart
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 HackerSpace. All rights reserved.
//

#import "XZChartCell.h"

#import "XZChart.h"

@interface XZChartCell ()

/** 画图View */
@property(nonatomic,weak)XZChart *chartView;


@end

@implementation XZChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configUI:(NSIndexPath *)indexPath
{
    if (self.chartView) {
        [self.chartView removeFromSuperview];
        self.chartView = nil;
    }
    
    
    NSArray *ary0 = @[@"1.20", @"1.50", @"0.50", @"1.60", @"1.85", @"0.83", @"2.83"];
    NSArray *ary1 = @[@"23",@"25",@"15",@"30",@"42",@"32",@"40"];
    NSArray *ary2 = @[@"1001",@"1722",@"1220",@"1666",@"1888",@"1569",@"1536"];
    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52",@"22",@"1"];
    NSArray *ary4 = @[@"2.10", @"3.50", @"3.99", @"1.00", @"0.99", @"0.00", @"2.50"];
    
    
    
    XZChart *chartView = [[XZChart alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              style:self.chartType];
    
    self.chartView= chartView;
    
    self.chartView.xAxis = [self getXTitles:7];
    switch (indexPath.row) {
        case 0:
        {
            self.chartView.lineChartValue = @[ary0];
            
            self.chartView.barChartValue = @[ary4];
        }
            break;
        case 1:
        {
            self.chartView.lineChartValue = @[ary1];
            
            self.chartView.barChartValue = @[ary3];
        }
            break;
        case 2:
        {
            self.chartView.lineChartValue = @[ary1];
            
            self.chartView.barChartValue = @[ary2];
        }
            break;
        case 3:
        {
            self.chartView.lineChartValue = @[ary3];
            
            self.chartView.barChartValue = @[ary1];
        }
            break;
        case 4:
        {
            self.chartView.lineChartValue = @[ary4];
            
            self.chartView.barChartValue = @[ary0];
        }
            break;
            
        default:
            break;
    }
    
    
    self.chartView.unitY = @"价格/元";
    self.chartView.lineColor = [UIColor redColor];
    self.chartView.isShowHorizonLine = YES;
    self.chartView.isShowChartValue = YES;
    
    [self.chartView showInView:self.contentView];
    
}


- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"6.%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
