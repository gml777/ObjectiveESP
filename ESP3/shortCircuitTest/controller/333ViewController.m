//
//  333ViewController.m
//  segement
//
//  Created by 陈浩 on 17/1/23.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "11closeTestViewController.h"
#import "333ViewController.h"
#import "XMGNavigationController.h"
@interface _33ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@property (weak, nonatomic) IBOutlet UILabel *transformLabel;
@property (weak, nonatomic) IBOutlet UILabel *coolerLabel;
@property (weak, nonatomic) IBOutlet UILabel *pe1Label;
@property (weak, nonatomic) IBOutlet UILabel *pe2Label;
@property (weak, nonatomic) IBOutlet UILabel *dc1Label;
@property (weak, nonatomic) IBOutlet UILabel *dc2Label;
@property (weak, nonatomic) IBOutlet UITextField *daotongjiaoInput;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmDescription;

@property (weak, nonatomic) IBOutlet UILabel *i2Limit;
@property (weak, nonatomic) IBOutlet UILabel *actualI2;
@property (weak, nonatomic) IBOutlet UILabel *u1Label;
@property (weak, nonatomic) IBOutlet UILabel *i1Label;
@property (weak, nonatomic) IBOutlet UILabel *u2Label;
@property (weak, nonatomic) IBOutlet UILabel *i2Label;
@property (weak, nonatomic) IBOutlet UILabel *hhl;


@end

@implementation _33ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interval = GMLTimerInterval;
    [self startTimer];
  //  [self setupNavBar];
    self.navigationItem.title=currentName;//@"短路实验第8/12步";
}
-(void)setupNavBar
{
    UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [leftbtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [leftbtn sizeToFit];
    [leftbtn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView=[[UIView alloc]initWithFrame:leftbtn.bounds];
    [contentView addSubview:leftbtn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:contentView];
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightbtn sizeToFit];
    [rightbtn addTarget:self action:@selector(runStateRight) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightContentView=[[UIView alloc]initWithFrame:rightbtn.bounds];
    [rightContentView addSubview:rightbtn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightContentView];
}
-(void)runStateRight
{
}

-(void)game
{
}
-(void)startTimer
{
    if(self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(runStateLibModbusRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [singletonModbus disconnect];//XMGLogFunc
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.deviceNameLabel.text = currentName;
    self.operatingStatusLabel.text=GMLcurrentState;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
       // NSLog(@"告警操作将要出现连接错误%@",error.localizedDescription);
    }];
}

/*-(void)viewDidDisappear:(BOOL)animated
 {
 [super viewDidDisappear:animated];
 [self stopTimer];
 }*/
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}
-(void)setInterval:(NSTimeInterval)interval
{
    _interval = interval;
    [self stopTimer];
    [self startTimer];
    [singletonModbus disconnect];
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
        self.communicationStatusLabel.text=@"通信中断";
        
    } else {
        self.communicationStatusLabel.text=@"正常";
    }
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            self.alarmStatusLabel.text=@"正常";
        } else {
            self.alarmStatusLabel.text=@"告警";
        }
    } failure:^(NSError *error) {
        self.alarmStatusLabel.text=@"?";
    }];
    [singletonModbus readRegistersFrom:(197 - 1) count:7 success:^(NSArray *array) {
        if([array[6] intValue] < 10000)
            self.controlLabel.text = [NSString stringWithFormat:@"%@",array[6]];
        else
            self.controlLabel.text = [NSString stringWithFormat:@"%d",[array[6] intValue] - 65536];
        if ([array[4] intValue] < 10000) {
            self.transformLabel.text = [NSString stringWithFormat:@"%@",array[4]];
        } else {
            self.transformLabel.text = [NSString stringWithFormat:@"%d",[array[4] intValue] - 65536];
        }
        if ([array[3] intValue] < 1000) {
            self.coolerLabel.text = [NSString stringWithFormat:@"%@",array[3]];
        } else {
            self.coolerLabel.text = [NSString stringWithFormat:@"%d",[array[3] intValue] - 65536];
        }
        if ([array[0] intValue] < 10000) {
            self.pe1Label.text = [NSString stringWithFormat:@"%@",array[0]];
        } else {
            self.pe1Label.text = [NSString stringWithFormat:@"%d",[array[0] intValue] - 65536];
        }
        if ([array[1] intValue] < 10000) {
            self.pe2Label.text = [NSString stringWithFormat:@"%@",array[1]];
        } else {
            self.pe2Label.text = [NSString stringWithFormat:@"%d",[array[1] intValue] - 65536];
        }
        
    } failure:^(NSError *error) {
        // NSLog(@"error in run state read 197~205:%@",error.localizedDescription);
        self.controlLabel.text = @"?";
        self.transformLabel.text=@"?";
        self.coolerLabel.text = @"?";
        self.pe1Label.text=@"?";
        self.pe2Label.text = @"?";
    }];
    [singletonModbus readRegistersFrom:(1044 - 1) count:1 success:^(NSArray *array) {
        self.i2Limit.text = [NSString stringWithFormat:@"%@",array[0]];
    } failure:^(NSError *error) {
        self.i2Limit.text = @"?";
    }];
    [singletonModbus readRegistersFrom:(29 - 1) count:1 success:^(NSArray *array) {
        self.actualI2.text = [NSString stringWithFormat:@"%@",array[0]];
    } failure:^(NSError *error) {
        self.actualI2.text = @"?";
    }];
    [singletonModbus readRegistersFrom:(213 - 1) count:2 success:^(NSArray *array) {
        self.dc1Label.text = [NSString stringWithFormat:@"%@",array[0]];
        self.dc2Label.text = [NSString stringWithFormat:@"%@",array[1]];
    } failure:^(NSError *error) {
        self.dc1Label.text=@"?";
        self.dc2Label.text = @"?";
    }];
    [singletonModbus readRegistersFrom:(25 - 1) count:7 success:^(NSArray *array) {
        self.u1Label.text = [NSString stringWithFormat:@"%@",array[0]];
        self.i1Label.text = [NSString stringWithFormat:@"%@",array[1]];
        self.u2Label.text = [NSString stringWithFormat:@"%@",array[3]];
        self.i2Label.text =[NSString stringWithFormat:@"%@",array[4]];
        self.hhl.text =[NSString stringWithFormat:@"%@",array[6]];
    } failure:^(NSError *error) {
        self.u1Label.text = @"?";
        self.i1Label.text=@"?";
        self.u2Label.text = @"?";
        self.i2Label.text=@"?";
        self.hhl.text=@"?";
    }];
}
#pragma mark-修改前后实时刷新显示
- (IBAction)OK:(id)sender {
    int dtj = [self.daotongjiaoInput.text intValue];
    if(dtj <= 20) dtj = 20;
    if (dtj >= 80) dtj = 80;
    [singletonModbus writeRegister:(1089 - 1) to:dtj success:^{
       // NSLog(@"write daotongjiao success");
    } failure:^(NSError *error) {
       // NSLog(@"write daotongjiao failed");
    }];
}
- (IBAction)cancel:(id)sender {
    [singletonModbus writeRegister:(1089 - 1) to:20 success:^{
    } failure:^(NSError *error) {
        return ;
    }];
    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"如果您确实要结束短路实验，请点下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"下一步" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        _1closeTestViewController *wuf=[[_1closeTestViewController alloc]initWithNibName:@"11closeTestViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    }];
    [alert1 addAction:okAction1];
    UIAlertAction *cancelAction1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert1 addAction:cancelAction1];
    [self presentViewController:alert1 animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITextField *view in self.view.subviews) {
        [view resignFirstResponder];
    }
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
