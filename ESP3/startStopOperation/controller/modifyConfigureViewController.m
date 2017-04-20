//
//  modifyConfigureViewController.m
//  ESP3
//
//  Created by 陈浩 on 2017/2/21.
//  Copyright © 2017年 Nonvia. All rights reserved.
//
#import "HighFrequencyList.h"
#import "modifyConfigureViewController.h"
#import <sqlite3.h>
@interface modifyConfigureViewController ()

@end

@implementation modifyConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)modifyConfigure:(id)sender {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你确定要修改这一组配置吗？" message:@"想好了？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self updateData];
     //   sender.selected = !sender.selected;
    }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)updateData
{
    NSString *mingzi=self.modifyName.text;
    NSString *ipdizhi=self.modifyIPAddress.text;
    NSString *zhuangtai=@"停运";
    NSString *duankouhao=self.modifyPortNumber.text;
    NSString *shebeihao=self.modifyDeviceID.text;
    //  NSLog(@"%@----%@---%@",mingzi,ipdizhi,zhuangtai);
    /*  NSString *beforenames = self.itemBeforeModify.names;
     NSString *beforeips = self.itemBeforeModify.ips;
     HFLStates beforetype = self.itemBeforeModify.type;
     NSInteger beforeportNumber = self.itemBeforeModify.portNumber;
     NSInteger beforedeviceID = self.itemBeforeModify.deviceID;*/
    NSInteger beforeIDNO = self.itemBeforeModify.IDNO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
   // NSLog(@"参数配置修改%@",path);
    sqlite3 *db;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
     //   NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
     //   NSLog(@"run sql failed:%s",error);
    }
    
    // char *gml="update t_modbusConnectConfigure set zhuangtai='运行' where mingzi='1A11'";
    NSString *gml=[NSString stringWithFormat:@"update t_modbusConnectConfigure set mingzi='%@',ipdizhi='%@',zhuangtai='%@',duankouhao=%@,shebeihao=%@ where IDNO=%d",mingzi,ipdizhi,zhuangtai,duankouhao,shebeihao,beforeIDNO];
    
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        //NSLog(@"run sql failed:%s",error);
    }
    sqlite3_close(db);
}
-(void)viewWillAppear:(BOOL)animated
{
    [singletonModbus connect:^{
        self.modifyCommunicationStatus.text=@"正常";
    } failure:^(NSError *error) {
        self.modifyCommunicationStatus.text=@"中断";
    }];
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            self.modifyAlarmStatus.text=@"正常";
        } else {
            self.modifyAlarmStatus.text=@"告警";
        }
    } failure:^(NSError *error) {
        self.modifyAlarmStatus.text=@"?";
        self.modifyCommunicationStatus.text=@"中断";
    }];
    //  [self selectData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITextField *view in self.view.subviews) {
        [view resignFirstResponder];
    }
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
