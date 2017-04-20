//
//  11closeTestViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "12lahuViewController.h"
#import "11closeTestViewController.h"
#import "XMGNavigationController.h"
@interface _1closeTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *testRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortCircuitRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *testCurrentValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortCircuitCurrentValueLabel;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _1closeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第9/12步";
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
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            self.alarmStatusLabel.text=@"正常";
        } else {
            self.alarmStatusLabel.text=@"告警";
        }
    } failure:^(NSError *error) {
        self.alarmStatusLabel.text=@"?";
    }];
    [singletonModbus readBitsFrom:(16395 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] boolValue] == TRUE) {
            self.testCurrentValueLabel.text = @"打开";
        } else {
            self.testCurrentValueLabel.text = @"关闭";
        }
    } failure:^(NSError *error) {
        self.testCurrentValueLabel.text = @"？";
    }];
    [singletonModbus readBitsFrom:(16465 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] boolValue] == TRUE) {
            self.shortCircuitCurrentValueLabel.text = @"打开";
        } else {
            self.shortCircuitCurrentValueLabel.text = @"关闭";
        }
    } failure:^(NSError *error) {
        self.shortCircuitCurrentValueLabel.text = @"？";
    }];
    if ([self checkCommunicationInterrupt]) {
        self.communicationStatusLabel.text=@"中断";
        
    } else {
        self.communicationStatusLabel.text=@"正常";
        
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

- (IBAction)wyf:(id)sender {
    [singletonModbus writeBit:(16395 - 1) to:FALSE success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    [singletonModbus writeBit:(16465 - 1) to:FALSE success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
    _2lahuViewController *wuf=[[_2lahuViewController alloc]initWithNibName:@"12lahuViewController" bundle:nil];
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
