//
//  456ViewController.m
//  segement
//
//  Created by 陈浩 on 17/1/23.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "456ViewController.h"
#import "222ViewController.h"
@interface _56ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *i2LimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *arcRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *arcCurrentValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowAlarmRawValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowAlarmCurrentValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowTripRawValue;
@property (weak, nonatomic) IBOutlet UILabel *secondaryVoltageLowTripCurrentValue;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,weak)NSTimer *timer;
@property(nonatomic,weak)NSTimer *delayTimer;
@end

@implementation _56ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setupNavBar];
    self.navigationItem.title=currentName;//@"短路实验第6/12步";
    //[self startTimer];
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
{//刚开始建立连接就读，连接都没建好就开始读，多次读失败，程序崩溃
    [super viewDidAppear:animated];
  //  [self startTimer];
    [singletonModbus connect:^{
        
    } failure:^(NSError *error) {
        self.communicationStatusLabel.text = @"?";
    }];
    self.nextBtn.backgroundColor=[UIColor grayColor];
  //  self.delayTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(delayTimer) userInfo:nil repeats:NO];
//暂时先把它注释起来，有好办法再来处理
 /*   [singletonModbus readRegistersFrom:(1057 - 1) count:1 success:^(NSArray *array) {
        self.arcRawValueLabel.text=array[0];
    } failure:^(NSError *error) {
        self.arcRawValueLabel.text=@"?";
    }];
    [singletonModbus readRegistersFrom:(1093 - 1) count:2 success:^(NSArray *array) {
        self.secondaryVoltageLowAlarmRawValue.text=array[0];
        self.secondaryVoltageLowTripRawValue.text=array[1];
    } failure:^(NSError *error) {
        self.secondaryVoltageLowAlarmRawValue.text=@"?";
        self.secondaryVoltageLowTripRawValue.text=@"?";
    }];*/
}
/*-(void)delayStartTimer
{
    [self startTimer];
    [self.delayTimer invalidate];
    self.delayTimer=nil;
}*/
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
    if ([self.arcCurrentValueLabel.text isEqual:@0] && [self.secondaryVoltageLowAlarmCurrentValue.text isEqual:@0] && [self.secondaryVoltageLowTripCurrentValue.text isEqual:@0] && ([self.i2LimitLabel.text isEqual:@1200] || [self.i2LimitLabel.text isEqual:@1700])) {
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
        self.nextBtn.backgroundColor=[UIColor grayColor];
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
#pragma mark- 若拉弧设定值、二次电压低报警、跳闸是0且二次电流限制值是1200或1700，直接进入第7步，否则提示
- (IBAction)ok:(id)sender {
    XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
    _22ViewController *wuf=[[_22ViewController alloc]initWithNibName:@"222ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:NO];
    [temp pushViewController:wuf animated:NO];
 /*   if ([self.arcCurrentValueLabel.text isEqualToString:@"0"] && [self.secondaryVoltageLowAlarmCurrentValue.text isEqualToString:@"0"] && [self.secondaryVoltageLowTripCurrentValue.text isEqualToString:@"0"] && ([self.i2LimitLabel.text isEqualToString:@"1200"] || [self.i2LimitLabel.text isEqualToString:@"1700"])) {
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        _22ViewController *wuf=[[_22ViewController alloc]initWithNibName:@"222ViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [temp pushViewController:wuf animated:YES];
    }else{
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"请修改参数，再进行下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:okAction1];
        [self presentViewController:alert1 animated:YES completion:nil];
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelback:(id)sender {
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
- (IBAction)modify:(id)sender {
    [self stopTimer];
    [singletonModbus writeRegister:(1057 - 1) to:0 success:^{
        //[self startTimer];这个地方最好是这几个玩意儿都写成功了再开定时器，要不会有问题
    } failure:^(NSError *error) {
        
    }];
    [singletonModbus writeRegister:(1093 - 1) to:0 success:^{
       // [self startTimer];
    } failure:^(NSError *error) {
        
    }];
    [singletonModbus writeRegister:(1094 - 1) to:0 success:^{
       // [self startTimer];
    } failure:^(NSError *error) {
        
    }];
   /* NSString *str=self.i2LimitTextfield.text;
    int i2 = [str intValue];*/
    [singletonModbus writeRegister:(1044 - 1) to:1700 success:^{
       // [self startTimer];
    } failure:^(NSError *error) {
        
    }];
}

@end
