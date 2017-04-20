//
//  12lahuViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "12lahuViewController.h"
#import "13modSwiOpenViewController.h"
@interface _2lahuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *arcRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *arcCurrentValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowAlarmRawValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowAlarmCurrentValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowTripRawValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowTripCurrentValue;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _2lahuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第10/12步";
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
   // [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        self.communicationStatusLabel.text = @"?";
        self.operatingStatusLabel.text=@"?";
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.deviceNameLabel.text = currentName;
    self.operatingStatusLabel.text=GMLcurrentState;
}
-(void)runStateLibModbusRead
{
    if ([self checkCommunicationInterrupt]) {
        self.communicationStatusLabel.text=@"中断";
    } else {
        self.communicationStatusLabel.text=@"正常";
    }
    [singletonModbus readRegistersFrom:(1057 - 1) count:1 success:^(NSArray *array) {
        self.arcCurrentValueLabel.text=array[0];
    } failure:^(NSError *error) {
        self.arcCurrentValueLabel.text=@"?";
    }];
    [singletonModbus readRegistersFrom:(1093 - 1) count:2 success:^(NSArray *array) {
        self.secondaryVoltageLowAlarmCurrentValue.text=array[0];
        self.secondaryVoltageLowTripCurrentValue.text=array[1];
    } failure:^(NSError *error) {
        self.secondaryVoltageLowAlarmCurrentValue.text=@"?";
        self.secondaryVoltageLowTripCurrentValue.text=@"?";
    }];
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            self.alarmStatusLabel.text=@"正常";
        } else {
            self.alarmStatusLabel.text=@"告警";
        }
    } failure:^(NSError *error) {
        self.alarmStatusLabel.text=@"?";
    }];
    if ([self.arcCurrentValueLabel.text isEqual:@0] && [self.secondaryVoltageLowAlarmCurrentValue.text isEqual:@0] && [self.secondaryVoltageLowTripCurrentValue.text isEqual:@0]) {
      //  self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
      //  self.nextBtn.backgroundColor=[UIColor grayColor];
    }
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

- (IBAction)wyfgml:(id)sender {
    [singletonModbus writeRegister:(1057 - 1) to:5 success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    [singletonModbus writeRegister:(1093 - 1) to:10 success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    [singletonModbus writeRegister:(1094 - 1) to:5 success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
    _3modSwiOpenViewController *wuf=[[_3modSwiOpenViewController alloc]initWithNibName:@"13modSwiOpenViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:NO];
    [temp pushViewController:wuf animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
