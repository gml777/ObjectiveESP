//
//  222ViewController.m
//  segement
//
//  Created by 陈浩 on 17/1/23.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "222ViewController.h"
#import "333ViewController.h"
@interface _22ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *testRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortCircuitRawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *testCurrentValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortCircuitCurrentValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _22ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   [self setupNavBar];
    self.navigationItem.title=currentName;//@"短路实验第7/12步";
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
    self.nextBtn.backgroundColor=[UIColor grayColor];//XMGARGBColor(255, 217, 95, 95);
    self.nextBtn.layer.borderWidth=1;
    self.nextBtn.layer.borderColor=XMGARGBColor(255, 217, 95, 95).CGColor;
    self.nextBtn.layer.cornerRadius=4.5;
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
    if ([self.testCurrentValueLabel.text isEqualToString:@"打开"] && [self.shortCircuitCurrentValueLabel.text isEqualToString:@"打开"]) {
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
        self.nextBtn.backgroundColor=[UIColor grayColor];
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
#pragma mark 如果参数已经修改，可以点击下一步；否则，下一步按钮变灰，点击弹出请修改参数，再进行下一步
- (IBAction)OK:(id)sender {
    if([self.testCurrentValueLabel.text isEqualToString:@"打开"] && [self.shortCircuitCurrentValueLabel.text isEqualToString:@"打开"]){
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        _33ViewController *wuf=[[_33ViewController alloc]initWithNibName:@"333ViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    }else{
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"请修改参数，再进行“下一步”" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:okAction1];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
  }
- (IBAction)cancel:(id)sender {
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
- (IBAction)modify:(id)sender {
    [self stopTimer];
    [singletonModbus writeBit:(16395 - 1) to:TRUE success:^{
       
    } failure:^(NSError *error) {
    }];
    [singletonModbus writeBit:(16465 - 1) to:TRUE success:^{
      
    } failure:^(NSError *error) {
    }];
    [self startTimer];
}

@end
