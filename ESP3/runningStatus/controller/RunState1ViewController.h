//
//  RunState1ViewController.h
//  ModbusDemo
//
//  Created by 陈浩 on 16/12/20.
//
//

#import <UIKit/UIKit.h>

@interface RunState1ViewController : UIViewController
@property(nonatomic,assign)NSTimeInterval interval;
@property(nonatomic,strong)UITextField *kzqText;
@property(nonatomic,strong)UITextField *byqText;
@property(nonatomic,strong)UITextField *lqyText;

@property(nonatomic,strong)UITextField *pe1Text;

@property(nonatomic,strong)UITextField *pe2Text;

@property(nonatomic,strong)UITextField *i1Text;

@property(nonatomic,strong)UITextField *u1Text;
@property(nonatomic,strong)UITextField *u2Text;
@property(nonatomic,strong)UITextField *sparks;
@property(nonatomic,strong)UITextField *arcs;
@property(nonatomic,strong)UITextField *HWsparks;
@property(nonatomic,strong)UITextField *i2Text;
@property(nonatomic,strong)UITextField *hhlText;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)NSTimer *timer;
@end
