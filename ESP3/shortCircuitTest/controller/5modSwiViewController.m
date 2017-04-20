//
//  5modSwiViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "5modSwiViewController.h"
#import "XMGNavigationController.h"
#import "456ViewController.h"
@interface _modSwiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
//告警描述是告警页面的信息，因为不方便页面切换，所以在这个地方简略显示，最多只显示两条，然后省略号
@property (weak, nonatomic) IBOutlet UILabel *alarmDescription;
@property (weak, nonatomic) IBOutlet UILabel *rawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _modSwiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第5/12步";
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
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        self.communicationStatusLabel.text = @"?";
    }];
    [self startTimer];

    [singletonModbus readBitsFrom:(1133 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] boolValue] == TRUE) {
            self.rawValueLabel.text = @"1";
        } else {
            self.rawValueLabel.text = @"0";
        }
    } failure:^(NSError *error) {
        self.rawValueLabel.text=@"?";
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
    self.nextBtn.backgroundColor=[UIColor grayColor];//XMGARGBColor(255, 217, 95, 95);
    self.nextBtn.layer.borderWidth=1;
    self.nextBtn.layer.borderColor=XMGARGBColor(255, 217, 95, 95).CGColor;
    self.nextBtn.layer.cornerRadius=4.5;

}
-(void)runStateLibModbusRead
{//通信状态：正常或中断；运行状态：运行中或停运
    if ([self checkCommunicationInterrupt]) {
        self.communicationStatusLabel.text=@"中断";
    } else {
        self.communicationStatusLabel.text=@"正常";
    }
    [singletonModbus readBitsFrom:(1133 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] boolValue] == TRUE) {
            self.currentValueLabel.text = @"1";
            self.alarmDescription.text=@"隔离开关跳闸";
        } else {
            self.currentValueLabel.text = @"0";
            self.alarmDescription.text=@"隔离开关接地";
        }
    } failure:^(NSError *error) {
        self.currentValueLabel.text=@"?";
    }];
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            
            self.alarmStatusLabel.text=@"正常";
        } else {
            
            self.alarmStatusLabel.text=@"告警";
        }

    } failure:^(NSError *error) {
        self.alarmDescription.text=@"?";
        self.alarmStatusLabel.text=@"?";
    }];
    if ([self.alarmStatusLabel.text isEqualToString:@"告警"] || [self.alarmDescription.text isEqualToString:@"隔离开关跳闸"] || [self.currentValueLabel.text isEqualToString:@"1"]) {
        self.nextBtn.backgroundColor=[UIColor grayColor];
    } else {
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    }
}
#pragma mark-通信中断返回YES，正常返回no
-(BOOL)checkCommunicationInterrupt
{
    if (1) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark- 若处于告警状态且告警描述为隔离开关跳闸，下一步变灰，无法下一步；无告警且已修改进入下一步
- (IBAction)wyf:(id)sender {
    if ([self.alarmStatusLabel.text isEqualToString:@"告警"] || [self.alarmDescription.text isEqualToString:@"隔离开关跳闸"] || [self.currentValueLabel.text isEqualToString:@"1"]) {
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"隔离开关参数未修改或告警未消除，无法进行下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:okAction1];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
    
     if([self.alarmStatusLabel.text isEqualToString:@"正常"] && [self.alarmDescription.text isEqualToString:@"隔离开关接地"]){
         XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
         _56ViewController *wuf=[[_56ViewController alloc]initWithNibName:@"456ViewController" bundle:nil];
         [self.navigationController popViewControllerAnimated:NO];
         [temp pushViewController:wuf animated:NO];
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)endExperiment:(id)sender {
    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"您确定要结束短路实验吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"结束" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert1 addAction:okAction1];
    UIAlertAction *cancelAction1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert1 addAction:cancelAction1];
    [self presentViewController:alert1 animated:YES completion:nil];
    [singletonModbus writeBit:(1133 - 1) to:YES success:^{
    } failure:^(NSError *error) {
    }];
}
- (IBAction)modify:(id)sender {
    [self stopTimer];
    [singletonModbus writeBit:(1133 - 1) to:NO success:^{
      [self startTimer];
    } failure:^(NSError *error) {
       [self startTimer];
    }];
}
- (IBAction)alarmReset:(id)sender {
    [self stopTimer];
    [singletonModbus writeBit:(16393 - 1) to:NO success:^{
        [self startTimer];
    } failure:^(NSError *error) {
        [self startTimer];
    }];
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
