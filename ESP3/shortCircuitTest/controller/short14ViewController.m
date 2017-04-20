//
//  short14ViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "short14ViewController.h"
#import "short15ViewController.h"
@interface short14ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *alarmDescription;
@end

@implementation short14ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第12/12步";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(id)sender {
    XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
    short15ViewController *wuf=[[short15ViewController alloc]initWithNibName:@"short15ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:NO];
    [temp pushViewController:wuf animated:NO];
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
