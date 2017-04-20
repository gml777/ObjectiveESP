//
//  shortCircuitTestViewController.m
//  ESP3
//
//  Created by 陈浩 on 17/1/15.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "shortCircuitTestViewController.h"
//#import "VICurveViewController.h"
#import "1stopViewController.h"
@interface shortCircuitTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceRunStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *u1Label;
@property (weak, nonatomic) IBOutlet UILabel *i1Label;
@property (weak, nonatomic) IBOutlet UILabel *u2Label;
@property (weak, nonatomic) IBOutlet UILabel *i2Label;
@property (weak, nonatomic) IBOutlet UILabel *sparkRateLabel;
@property(nonatomic,assign)NSTimeInterval interval;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation shortCircuitTestViewController
-(instancetype)init
{
    if (self==nil) {
        self=[super init];
      //  self.i2LimitOption=TRUE;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=currentName;//@"短路实验";
 //   [self setupNavBar];
  //  [self startTimer];
}

-(void)startTimer
{
    if(self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:GMLTimerInterval target:self selector:@selector(runStateLibModbusRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [singletonModbus disconnect];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        self.deviceNameLabel.text = @"?";
        self.deviceRunStateLabel.text=@"?";
        self.runStateLabel.text = @"?";
        self.runWayLabel.text=@"?";
        self.u1Label.text = @"?";
        self.i1Label.text=@"?";
        self.u2Label.text = @"?";
        self.i2Label.text=@"?";
        self.sparkRateLabel.text=@"?";
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
}


-(void)setInterval:(NSTimeInterval)interval
{
    _interval = interval;
    [self stopTimer];
    [self startTimer];
    [singletonModbus disconnect];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.deviceNameLabel.text = currentName;
    self.runStateLabel.text=GMLcurrentState;
}

#pragma mark-通信中断返回YES，正常返回no
-(BOOL)checkCommunicationInterrupt
{
    if (0) {
        return YES;
    } else {
        return NO;
    }
}
-(void)runStateLibModbusRead
{
    if ([self checkCommunicationInterrupt]) {
        self.deviceRunStateLabel.text=@"通信中断";
        
    } else {
        self.deviceRunStateLabel.text=@"正常";
    }
    [singletonModbus readRegistersFrom:(25 - 1) count:7 success:^(NSArray *array) {
        self.u1Label.text = [NSString stringWithFormat:@"%@",array[0]];
        self.i1Label.text = [NSString stringWithFormat:@"%@",array[1]];
        self.u2Label.text = [NSString stringWithFormat:@"%@",array[3]];
        self.i2Label.text =[NSString stringWithFormat:@"%@",array[4]];
        self.sparkRateLabel.text =[NSString stringWithFormat:@"%@",array[6]];
    } failure:^(NSError *error) {
        self.u1Label.text = @"?";
        self.i1Label.text=@"?";
        self.u2Label.text = @"?";
        self.i2Label.text=@"?";
        self.sparkRateLabel.text=@"?";
    }];
    [singletonModbus readRegistersFrom:(17 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual: @0]) {
            self.runWayLabel.text = @"Off";
        } else if([array[0] isEqual: @1]){
            self.runWayLabel.text = @"None";
        }
        else if([array[0] isEqual: @2]){
            self.runWayLabel.text = @"Average Current";
        }
        else if([array[0] isEqual: @3]){
            self.runWayLabel.text = @"Primary current";
        }
        else if([array[0] isEqual: @4]){
            self.runWayLabel.text = @"Voltage peak";
        }
        else if([array[0] isEqual: @5]){
            self.runWayLabel.text = @"Modulation";
        }
        else if([array[0] isEqual: @6]){
            self.runWayLabel.text = @"Spark";
        }
        else if([array[0] isEqual: @7]){
            self.runWayLabel.text = @"PCR";
        }
        else if([array[0] isEqual: @8]){
            self.runWayLabel.text = @"OpOpt";
        }
        else if([array[0] isEqual: @9]){
            self.runWayLabel.text = @"Pulse current";
        }
        else if([array[0] isEqual: @10]){
            self.runWayLabel.text = @"EPOQ";
        }
        else if([array[0] isEqual: @11]){
            self.runWayLabel.text = @"VIcurve";
        }
        else if([array[0] isEqual: @12]){
            self.runWayLabel.text = @"not used";
        }
        else if([array[0] isEqual: @13]){
            self.runWayLabel.text = @"Arc";
        }
        else if([array[0] isEqual: @14]){
            self.runWayLabel.text = @"Pulse width";
        }
        else if([array[0] isEqual: @15]){
            self.runWayLabel.text = @"Temperature";
        }
        else if([array[0] isEqual: @16]){
            self.runWayLabel.text = @"Voltage";
        }
        else if([array[0] isEqual: @17]){
            self.runWayLabel.text = @"Duty cycle";
        }
        
    } failure:^(NSError *error) {
        self.runWayLabel.text = @"?";
    }];
}



- (IBAction)manualOrAuto:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startCircuit:(id)sender {

    _stopViewController *gml=[[_stopViewController alloc]initWithNibName:@"1stopViewController" bundle:nil];
 
    [self.navigationController pushViewController:gml animated:NO];

}
- (IBAction)endShortCircuit:(id)sender {

    
[self.navigationController popToRootViewControllerAnimated:YES];
    
   // self.i2LimitOptionSeg.userInteractionEnabled = YES;
    
    
}
-(void)setupNavBar
{
   /* UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(runStateRight) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightContentView=[[UIView alloc]initWithFrame:rightbtn.bounds];
    [rightContentView addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightContentView];*/
    self.navigationItem.title = @"短路实验";
}
-(void)runStateRight
{return;
  /*  VICurveViewController *configure=[[VICurveViewController alloc]initWithNibName:@"VICurveViewController" bundle:nil];
    configure.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:configure animated:YES];*/
}


@end
