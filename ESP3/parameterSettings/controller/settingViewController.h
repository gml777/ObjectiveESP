//
//  settingViewController.h
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/22.

//

#import <UIKit/UIKit.h>

@interface settingViewController : UIViewController
@property(nonatomic,assign)NSTimeInterval interval;
@property(nonatomic,strong)UITextField *u2Limit;
@property(nonatomic,strong)UITextField *i2Limit;
@property(nonatomic,strong)UITextField *hhlLimit;
@property(nonatomic,strong)UITextField *hhlmd;
@property(nonatomic,strong)UITextField *tempu2;
@property(nonatomic,strong)UITextField *tempi2;
@property(nonatomic,strong)UITextField *temphhlLimit;
@property(nonatomic,strong)UITextField *temphhlmd;


@end

