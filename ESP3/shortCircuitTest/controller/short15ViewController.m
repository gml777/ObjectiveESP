//
//  short15ViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/8.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "XMGNavigationController.h"
#import "short15ViewController.h"
#import "short16ViewController.h"
@interface short15ViewController ()

@end

@implementation short15ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=currentName;//@"短路实验第15/16步";
}
- (IBAction)tap15:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
  /*  UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"您确定要结束短路实验吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"结束" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert1 addAction:okAction1];
    UIAlertAction *cancelAction1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert1 addAction:cancelAction1];
    [self presentViewController:alert1 animated:YES completion:nil];*/
  /*  UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"如果您已经把隔离开关切换到“电场”位置，请点下一步" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction1=[UIAlertAction actionWithTitle:@"下一步" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        XMGNavigationController *temp =(XMGNavigationController *)self.navigationController;
        short16ViewController *wuf=[[short16ViewController alloc]initWithNibName:@"short16ViewController" bundle:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [temp pushViewController:wuf animated:YES];
    }];
    [alert1 addAction:okAction1];
    UIAlertAction *cancelAction1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert1 addAction:cancelAction1];
    [self presentViewController:alert1 animated:YES completion:nil];*/
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
