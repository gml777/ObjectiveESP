//
//  HighFrequencyList.m
//  ESP3
//
//  Created by 陈浩 on 17/1/13.
//  Copyright © 2017年 Nonvia. All rights reserved.
//

#import "HighFrequencyList.h"

@implementation HighFrequencyList
/**
 *  查
 *//*
    -(void)selectData
    {
    NSString *path=NSHomeDirectory();
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
    NSLog(@"%@",path);
    sqlite3 *db;
    sqlite3_stmt *stmt;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
    NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,PRIMARY KEY('mingzi'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
    NSLog(@"run sql failed:%s",error);
    }
    NSString *mingzi=self.mingziText.text;
    NSString *gml=[NSString stringWithFormat:@"select * from t_modbusConnectConfigure where mingzi='%@'",mingzi];
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    result=sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result==SQLITE_OK) {
    while (sqlite3_step(stmt)==SQLITE_ROW) {
    char * mingzi=(char *)sqlite3_column_text(stmt, 0);
    char *ipdizhi=(char *)sqlite3_column_text(stmt, 1);
    char *zhuangtai=(char *)sqlite3_column_text(stmt, 2);
    int duankouhao=sqlite3_column_int(stmt, 3);
    int shebeihao=sqlite3_column_int(stmt, 4);
    NSString *strmingzi=[NSString stringWithUTF8String:mingzi];
    NSString *stripdizhi=[NSString stringWithUTF8String:ipdizhi];
    NSString *strzhuangtai=[NSString stringWithUTF8String:zhuangtai];
    NSLog(@"mingzi=%@,ipdizhi=%@,zhuangtai=%@,duankouhao=%d,shebeihao=%d",strmingzi,stripdizhi,strzhuangtai,duankouhao,shebeihao);
    }
    } else {
    NSLog(@"yu chu li shi bai");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    }

    *  改
    *//*
       -(void)updateData
       {
       NSString *mingzi=self.mingziText.text;
       NSString *ipdizhi=self.ipdizhiText.text;
       NSString *zhuangtai=self.zhuangtaiText.text;
       NSString *duankouhao=self.duankouhaoText.text;
       NSString *shebeihao=self.shebeihaoText.text;
       mingzi=[mingzi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       ipdizhi=[ipdizhi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       zhuangtai=[zhuangtai stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       duankouhao=[duankouhao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       shebeihao=[shebeihao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       if (![configureViewController isValidatIP:ipdizhi] || [mingzi isEqualToString:@""] || [ipdizhi isEqualToString:@""] || [zhuangtai isEqualToString:@""] || [duankouhao isEqualToString:@""] || [shebeihao isEqualToString:@""]) {
       UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你输入的东西不对" message:@"抱歉，请重新填写正确的东西！" preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       }];
       [alert addAction:okAction];
       [self presentViewController:alert animated:YES completion:nil];
       return ;
       }
       NSString *path=NSHomeDirectory();
       path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
       NSLog(@"%@",path);
       sqlite3 *db;
       int result = sqlite3_open([path UTF8String], &db);
       if (result != SQLITE_OK) {
       NSLog(@"open failed");
       }
       char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,PRIMARY KEY('mingzi'));";
       char *error;
       result=sqlite3_exec(db, sql, NULL, NULL, &error);
       if (result != SQLITE_OK) {
       NSLog(@"run sql failed:%s",error);
       }
       
       // char *gml="update t_modbusConnectConfigure set zhuangtai='运行' where mingzi='1A11'";
       NSString *gml=[NSString stringWithFormat:@"update t_modbusConnectConfigure set ipdizhi='%@'and zhuangtai='%@' and duankouhao=%@ and shebeihao=%@ where mingzi='%@'",ipdizhi,zhuangtai,duankouhao,shebeihao,mingzi];
       
       result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
       if (result != SQLITE_OK) {
       NSLog(@"run sql failed:%s",error);
       }
       sqlite3_close(db);
       }*/

@end
/**
 *  BEGIN TRANSACTION;
 
 ALTER TABLE "main"."t_modbusConnectConfigure" RENAME TO "_t_modbusConnectConfigure_old_20170117";
 
 CREATE TABLE "main"."t_modbusConnectConfigure" (
 "mingzi" text(4,0) NOT NULL,
 "ipdizhi" text(15,0) NOT NULL,
 "zhuangtai" text NOT NULL,
 "duankouhao" integer NOT NULL,
 "shebeihao" integer NOT NULL,
 "IDNO" integer NOT NULL,
	PRIMARY KEY("IDNO")
 );
 
 INSERT INTO "main"."t_modbusConnectConfigure" ("mingzi", "ipdizhi", "zhuangtai", "duankouhao", "shebeihao") SELECT "mingzi", "ipdizhi", "zhuangtai", "duankouhao", "shebeihao" FROM "main"."_t_modbusConnectConfigure_old_20170117";
 
 COMMIT;
 */
/*
 -(void)insertData
 {
 NSString *mingzi=self.mingziText.text;
 NSString *ipdizhi=self.ipdizhiText.text;
 NSString *zhuangtai=self.zhuangtaiText.text;
 NSString *duankouhao=self.duankouhaoText.text;
 NSString *shebeihao=self.shebeihaoText.text;
 mingzi=[mingzi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 ipdizhi=[ipdizhi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 zhuangtai=[zhuangtai stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 duankouhao=[duankouhao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 shebeihao=[shebeihao stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 if (![configureViewController isValidatIP:ipdizhi] || [mingzi isEqualToString:@""] || [ipdizhi isEqualToString:@""] || [zhuangtai isEqualToString:@""] || [duankouhao isEqualToString:@""] || [shebeihao isEqualToString:@""]) {
 UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你输入的东西不对" message:@"抱歉，请重新填写正确的东西！" preferredStyle:UIAlertControllerStyleAlert];
 UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
 }];
 [alert addAction:okAction];
 [self presentViewController:alert animated:YES completion:nil];
 return ;
 }
 NSString *path=NSHomeDirectory();
 path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
 NSLog(@"%@",path);
 sqlite3 *db;
 int result = sqlite3_open([path UTF8String], &db);
 if (result != SQLITE_OK) {
 NSLog(@"open failed");
 }
 char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,PRIMARY KEY('mingzi'));";
 char *error;
 result=sqlite3_exec(db, sql, NULL, NULL, &error);
 if (result != SQLITE_OK) {
 NSLog(@"run sql failed:%s",error);
 }
 NSString *gml=[NSString stringWithFormat:@"insert into t_modbusConnectConfigure(mingzi, ipdizhi,zhuangtai,duankouhao,shebeihao) values('%@', '%@', '%@', %@, %@)",mingzi,ipdizhi,zhuangtai,duankouhao,shebeihao];
 
 result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
 if (result != SQLITE_OK) {
 NSLog(@"run sql failed:%s",error);
 }
 sqlite3_close(db);
 }
 
 //  [self addFooterButton];
 
  UIAlertController *click = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你点击了第:%ld行",indexPath.row] message:@"message" preferredStyle:UIAlertControllerStyleAlert];
 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
 
 RunState1ViewController *runState=[[RunState1ViewController alloc]init];
 [self presentViewController:runState animated:NO completion:nil];
 NSLog(@"运行状态控制器显示了");
 }];
 [click addAction:cancelAction];
 [self presentViewController:click animated:YES completion:nil];*/

//[self dismissViewControllerAnimated:YES completion:nil];
/* if (indexPath.row % 2 == 0) {
 [UIApplication sharedApplication] GMLIPAddress = @"192.168.1.210";
 } else {
 GMLIPAddress = @"192.168.1.117";
 }

 let longPress = UILongPressGestureRecognizer(target: self, action: #selector(CalorieCountViewController.handleLongPress))
 yourTableView.addGestureRecognizer(longPress)
 
 func handleLongPress(sender: UILongPressGestureRecognizer){
 if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
 let touchPoint = longPressGestureRecognizer.locationInView(self.view)
 if let indexPath = yourTableView.indexPathForRowAtPoint(touchPoint) {
 // your code here, get the row for the indexPath or do whatever you want
 }
 }
 }
 
 
 */
/*    UIWindow *windows=[[UIWindow alloc]initWithFrame:CGRectMake(200, 300, 30, 30)];
 UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(200, 300, 30, 30)];
 [windows addSubview:btn];
 btn.backgroundColor=[UIColor magentaColor];
 windows.hidden=NO;*/
/*  NSInteger lconunt =4;
 CGFloat lW = screenW / lconunt;
 // for (int  i = 0; i < 4; i++) {
 UILabel *l1 = [[UILabel alloc]init];
 l1.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:l1];
 l1.text=@"ID";
 l1.textAlignment=UITextAlignmentCenter;
 l1.frame = CGRectMake(0, 10, lW, 33);
 //  }
 UILabel *l2 = [[UILabel alloc]init];
 l2.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:l2];
 l2.text=@"IP";
 l2.textAlignment=UITextAlignmentCenter;
 l2.frame = CGRectMake(lW, 10, lW, 33);
 
 UILabel *l3 = [[UILabel alloc]init];
 l3.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:l3];
 l3.text=@"name";
 l3.textAlignment=UITextAlignmentCenter;
 l3.frame = CGRectMake(lW * 2, 10, lW, 33);
 
 UILabel *l4 = [[UILabel alloc]init];
 l4.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:l4];
 l4.text=@"state";
 l4.textAlignment=UITextAlignmentCenter;
 l4.frame = CGRectMake(lW * 3, 10, lW, 33);
 
 CGFloat labelX = 10, labelY = 10, labelWidth = 120, labelHeight = 20, marginY = 40,imageW = 35;*/
/*  NSArray *alarmList = [NSArray arrayWithObjects:@"IP",@"name",@"state", nil];
 CGFloat lW = screenW / alarmList.count;
 for(int  i = 0; i < alarmList.count; i++)
 {
 UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(lW * i, 10, lW, 33)];
 label.text=alarmList[i];
 label.backgroundColor = [UIColor whiteColor];
 label.textAlignment=UITextAlignmentCenter;
 [self.view addSubview:label];
 }*/
/*  NSArray *buttonList = [NSArray arrayWithObjects:@"添加",@"删除",@"修改", nil];
 // CGFloat lW = screenW / alarmList.count;
 for(int  i = 0; i < buttonList.count; i++)
 {
 UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(lW * i, screenH - 40, lW, 40)];
 //button.text=alarmList[i];
 [button setTitle:buttonList[i] forState:UIControlStateNormal];
 button.backgroundColor = [UIColor whiteColor];
 [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
 if (i == 1) {
 [button addTarget:self action:@selector(configuration) forControlEvents:UIControlEventTouchUpInside];
 }
 //button.textAlignment=UITextAlignmentCenter;
 [self.view addSubview:button];
 }*/

