//
//  switchViewController.m
//  ESP3
//
//  Created by 陈浩 on 17/1/23.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "switchViewController.h"
#import "123ViewController.h"
@interface switchViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationInterruptedLabel;
@property(nonatomic,weak)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabal;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation switchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第2/12步";
  //  [self setupNavBar];
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
        self.communicationInterruptedLabel.text = @"?";
        self.operatingStatusLabal.text=@"?";
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
    self.operatingStatusLabal.text=GMLcurrentState;
    self.nextBtn.backgroundColor=[UIColor grayColor];//XMGARGBColor(255, 217, 95, 95);
    self.nextBtn.layer.borderWidth=1;
    self.nextBtn.layer.borderColor=XMGARGBColor(255, 217, 95, 95).CGColor;
    self.nextBtn.layer.cornerRadius=4.5;
}
-(void)runStateLibModbusRead
{//通信状态：正常或中断；运行状态：运行中或停运
    if ([self checkCommunicationInterrupt]) {
        self.communicationInterruptedLabel.text=@"中断";
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
        self.communicationInterruptedLabel.text=@"正常";
        self.nextBtn.backgroundColor=[UIColor grayColor];
    }
}
#pragma mark-“下一步”进行“通讯判断”，如果通讯正常，“下一步”为灰色，点击提示“请给高频电源断电”
- (IBAction)葛茂林:(id)sender {
    if([self checkCommunicationInterrupt]){
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        _23ViewController *wuf=[[_23ViewController alloc]initWithNibName:@"123ViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    }else{
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"请给高频电源断电" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert1 addAction:okAction1];
        [self presentViewController:alert1 animated:YES completion:nil];
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
- (IBAction)canel:(id)sender {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)game
{

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
