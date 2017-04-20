//
//  powerViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/7.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "powerViewController.h"
#import "5modSwiViewController.h"
@interface powerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation powerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setupNavBar];
    self.navigationItem.title=currentName;//@"短路实验第4/12步";
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
        self.nextBtn.backgroundColor=[UIColor grayColor];
    } else {
        self.communicationStatusLabel.text=@"正常";
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
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
#pragma mark- 如果当前通信正常，提示“警告，设备未断电，请勿操作”。如果通信中断，则无提示
- (IBAction)OK:(id)sender {
    if(![self checkCommunicationInterrupt]){
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        _modSwiViewController *wuf=[[_modSwiViewController alloc]initWithNibName:@"5modSwiViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    }else{
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"高频电源未送电，无法进行下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
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

@end
