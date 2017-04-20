//
//  13modSwiOpenViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "13modSwiOpenViewController.h"
#import "short14ViewController.h"
@interface _3modSwiOpenViewController ()
@property (strong, nonatomic) IBOutlet UIView *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *communicationStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatingStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *rawValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *alarmDescription;
@end

@implementation _3modSwiOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第11/12步";
}
- (IBAction)tap:(id)sender {
    [singletonModbus writeBit:(1133 - 1) to:true success:^{
        
    } failure:^(NSError *error) {
        return ;
    }];
    XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
    short14ViewController *wuf=[[short14ViewController alloc]initWithNibName:@"short14ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:NO];
    [temp pushViewController:wuf animated:NO];}

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
