//
//  1stopViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
#import "GMLButton.h"
#import "XMGNavigationController.h"
#import "1stopViewController.h"
#import "switchViewController.h"
@interface _stopViewController ()
@property (weak, nonatomic) IBOutlet UILabel *communicateStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *runStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet GMLButton *nextBtn;
@property(nonatomic,weak)NSTimer *timer;
@end

@implementation _stopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第1/12步";
    GMLButton *btn=[GMLButton cornerRadius:5 backgroundColor:[UIColor blueColor] titleColor:[UIColor blueColor]];
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
        self.communicateStateLabel.text = @"?";
        self.runStateLabel.text=@"?";
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
    self.runStateLabel.text=GMLcurrentState;
    self.nextBtn.backgroundColor=[UIColor grayColor];//XMGARGBColor(255, 217, 95, 95);
    self.nextBtn.layer.borderWidth=1;
    self.nextBtn.layer.borderColor=XMGARGBColor(255, 217, 95, 95).CGColor;
    self.nextBtn.layer.cornerRadius=4.5;
}
-(void)runStateLibModbusRead
{//通信状态：正常或中断；运行状态：运行中或停运
    if ([self checkCommunicationInterrupt]) {
        self.communicateStateLabel.text=@"中断";
        self.nextBtn.backgroundColor=XMGARGBColor(255, 217, 95, 95);
    } else {
        self.communicateStateLabel.text=@"正常";
        self.nextBtn.backgroundColor=[UIColor grayColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 如果电源已经停运，可以点击下一步；否则，下一步按钮变灰，点击弹出电源未停运，无法进行下一步
- (IBAction)tap:(id)sender {
    if([self checkCommunicationInterrupt]){
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        switchViewController *wuf=[[switchViewController alloc]initWithNibName:@"switchViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [temp pushViewController:wuf animated:NO];
    /*    [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:wuf animated:NO];
        [self.navigationController pushViewController:wuf animated:NO];*/
    }else{
       // self.nextBtn.backgroundColor=[UIColor darkGrayColor];
       // [self.nextBtn setBackgroundColor:[UIColor darkGrayColor]];
    //self.nextBtn.enabled=NO;
        UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"电源未停运，无法进行“下一步”" message:nil preferredStyle:UIAlertControllerStyleAlert];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
