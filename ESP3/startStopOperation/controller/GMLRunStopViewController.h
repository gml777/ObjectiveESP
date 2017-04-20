//
//  GMLRunStopViewController.h
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/22.
//
//

#import <UIKit/UIKit.h>

@interface GMLRunStopViewController : UIViewController
@property(nonatomic,assign)NSTimeInterval interval;
//@property(nonatomic,strong)NSString *qidong;
//@property(nonatomic,strong)NSString *tingzhi;
//@property(strong,nonatomic)UIButton *alarmReset;
//@property(nonatomic,strong)NSArray *runWay;
//@property(nonatomic,strong)UILabel *runway;
@property(nonatomic,weak)NSTimer *timer;
@end
