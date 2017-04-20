//
//  short16ViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "short16ViewController.h"

@interface short16ViewController ()

@end

@implementation short16ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第16/16步";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap16:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"如果高频电源已恢复上电，请点下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"下一步" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       // [self.navigationController popViewControllerAnimated:YES];
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
