//
//  HFLTableViewCell.h
//  ESP3
//
//  Created by 陈浩 on 17/1/13.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HighFrequencyList;
@interface HFLTableViewCell : UITableViewCell

@property(nonatomic,strong)HighFrequencyList *list;

@property (weak, nonatomic) IBOutlet UILabel *mingzi;
@property (weak, nonatomic) IBOutlet UILabel *ipdizhi;
@property (weak, nonatomic) IBOutlet UIImageView *zhuangtai;



@end
