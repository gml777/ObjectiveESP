//
//  123ViewController.m
//  segement
//
//  Created by 陈浩 on 17/1/23.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "123ViewController.h"
#import "powerViewController.h"
@interface _23ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _23ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self setupNavBar];
    self.navigationItem.title=currentName;//@"短路实验第3/12步";
}
-(void)setupNavBar
{
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
    self.deviceNameLabel.text = currentName;
   // self.operatingStatusLabal.text=GMLcurrentState;
    self.nextBtn.backgroundColor=[UIColor grayColor];//XMGARGBColor(255, 217, 95, 95);
    self.nextBtn.layer.borderWidth=1;
    self.nextBtn.layer.borderColor=XMGARGBColor(255, 217, 95, 95).CGColor;
    self.nextBtn.layer.cornerRadius=4.5;
}
-(void)runStateLibModbusRead
{//通信状态：正常或中断；运行状态：运行中或停运
    if ([self checkCommunicationInterrupt]) {
        self.communicationStatusLabel.text=@"中断";
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
        self.communicationStatusLabel.text=@"正常";
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
//如果当前通信正常，提示“警告，设备未断电，请勿操作”。如果通信中断，则无提示
- (IBAction)gml:(id)sender {
  /*  UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"注：如果已经将隔离刀闸切换到”接地“位置，请点下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"下一步" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        powerViewController *wuf=[[powerViewController alloc]initWithNibName:@"powerViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [temp pushViewController:wuf animated:YES];
    }];
    [alert1 addAction:okAction1];
    UIAlertAction *cancelAction1=[UIAlertAction actionWithTitle:@"还没接地" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert1 addAction:cancelAction1];
    [self presentViewController:alert1 animated:YES completion:nil];*/
    if([self checkCommunicationInterrupt]){
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        powerViewController *wuf=[[powerViewController alloc]initWithNibName:@"powerViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    }else{
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"警告，设备未断电，请勿操作" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:okAction1];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endExperiment:(id)sender {//结束实验，弹出确认框，结束或取消
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
@end
