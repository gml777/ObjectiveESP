//
//  configureViewController.m
//  ModbusDemo
//
//  Created by 陈浩 on 17/1/3.
//
///Users/chenhao/Desktop/ESP3/ESP3
/**
 创建表
create table if not EXISTS t_cjb(xingming text not NULL,shuxue integer NOT NULL,yuwen integer NOT NULL,yingyu integer NOT NULL)
 BEGIN TRANSACTION;
 修改表的结构
 ALTER TABLE "main"."t_cjb" RENAME TO "_t_cjb_old_20170116";
 
 CREATE TABLE "main"."t_cjb" (
 "xingming" text,
 "shuxue" integer,
 "yuwen" integer NOT NULL,
 "yingyu" integer NOT NULL
 );
 
 INSERT INTO "main"."t_cjb" ("xingming", "shuxue", "yuwen", "yingyu") SELECT "xingming", "shuxue", "yuwen", "yingyu" FROM "main"."_t_cjb_old_20170116";
 
 COMMIT;
 
 CREATE TABLE "main"."<table_name>" (
 "mingzi" text(4,0) NOT NULL,
 "ipdizhi" text(15,0) NOT NULL,
 "zhuangtai" text NOT NULL,
 "duankouhao" integer NOT NULL,
 "shebeihao" integer NOT NULL,
	PRIMARY KEY("mingzi")
 );
 
 删除表
 drop TABLE t_cjb
 插入,往打开的数据库的某个表里插入数据，一次只能插一行数据
 insert into 表名(字段列表) values(值的列表)
 INSERT INTO t_modbusConnectConfigure(mingzi,ipdizhi,zhuangtai,duankouhao,shebeihao) VALUES('1A22','192.168.0.102','run',502,1);
 修改
 update 表名 set 字段名1=值1,字段名2=值2,字段名3=值3,.....字段名n=值n where 条件
 UPDATE t_modbusConnectConfigure SET zhuangtai='运行',duankouhao=500 WHERE mingzi='1A22';
 删除(删除 修改操作之前搞个UIAlertController确认一下)
 delete from 表名 where 条件
 DELETE FROM t_modbusConnectConfigure WHERE mingzi='1A22';
 查询
 select 字段列表 from 表名 *代表所有的字段
 where 条件 order by 字段名
 SELECT * FROM t_modbusConnectConfigure;
 SELECT mingzi AS name FROM t_modbusConnectConfigure;
 SELECT * FROM t_modbusConnectConfigure WHERE shebeihao=1;
 SELECT IPdizhi AS IP地址 FROM t_modbusConnectConfigure WHERE duankouhao=502
 SELECT * FROM t_modbusConnectConfigure WHERE IPdizhi LIKE '192.%';
 SELECT * FROM t_modbusConnectConfigure WHERE shebeihao<2;
 SELECT count(*)  FROM t_modbusConnectConfigure WHERE shebeihao<2 AND shebeihao>0;
 SELECT *FROM t_modbusConnectConfigure WHERE duankouhao>500 OR duankouhao<0;
 SELECT *FROM t_modbusConnectConfigure WHERE duankouhao!=501;
 SELECT * FROM t_modbusConnectConfigure ORDER BY IPdizhi;
 SELECT *FROM t_modbusConnectConfigure ORDER BY mingzi DESC;
 SELECT * FROM t_modbusConnectConfigure WHERE shebeihao>0 ORDER BY IPdizhi DESC;
 SELECT sum(shebeihao) FROM t_modbusConnectConfigure;
 SELECT avg(duankouhao) FROM t_modbusConnectConfigure;
 SELECT *,duankouhao+shebeihao AS 计算列 FROM t_modbusConnectConfigure;
 */

#import "configureViewController.h"
//#import "GMLHighFrequencyListViewcontroller.h"
#import "RunState1ViewController.h"
#import "GMLRunStopViewController.h"
#import "settingViewController.h"
#import "warningViewController.h"
#import "XMGNavigationController.h"
#import "XMGTabBarController.h"
//#import "CSNetAddressKeyboard.h"
#import <sqlite3.h>
@interface configureViewController ()
@property(nonatomic,strong)NSString *ipAddress;
@property(nonatomic,strong)NSString *deviceName;
@property (weak, nonatomic) IBOutlet UITextField *communicationStatus;
@property (weak, nonatomic) IBOutlet UITextField *alarmStatus;

@property(nonatomic,assign)NSInteger port;
@property(nonatomic,assign)NSInteger deviceID;
@end

@implementation configureViewController
-(configureViewController *)configure
{
    if (!_configure) {
        configureViewController *configure = [[configureViewController alloc]initWithNibName:@"configureViewController" bundle:nil];
        
        _configure = configure;
    }
    return _configure;
}

-(void)viewWillAppear:(BOOL)animated
{
    [singletonModbus connect:^{
        self.communicationStatus.text=@"正常";
    } failure:^(NSError *error) {
        self.communicationStatus.text=@"中断";
    }];
    [singletonModbus readBitsFrom:(16393 - 1) count:1 success:^(NSArray *array) {
        if ([array[0] isEqual:@0]) {
            self.alarmStatus.text=@"正常";
        } else {
            self.alarmStatus.text=@"告警";
        }
    } failure:^(NSError *error) {
        self.alarmStatus.text=@"?";
        self.communicationStatus.text=@"中断";
    }];
  //  [self selectData];
}
- (BOOL)isValidatIP:(NSString *)ipAddress{
    
    NSString  *urlRegEx =@"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:ipAddress];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  /*  if (GMLUpdateOrAdd) {
        self.navigationItem.title=@"修改配置";
        [self.operateButton setTitle:@"修改" forState:UIControlStateNormal];
    } else {
        self.navigationItem.title=@"添加配置";
        [self.operateButton setTitle:@"添加" forState:UIControlStateNormal];
    }
    */
  /*  CGFloat labelX = screenW / 2 - 120, labelY = 100, labelWidth = 160, labelHeight = 30, marginY = 40, deltaX = 40;
    NSArray *alarmList = [NSArray arrayWithObjects:@"IP地址",@"名称",@"端口号",@"deviceID",nil];
    for(int  i = 0; i < alarmList.count; i++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY + marginY * i, labelWidth, labelHeight)];
        label.text=alarmList[i];
     //   [self.view addSubview:label];
    }
    UITextField *ipAddress = [[UITextField alloc]initWithFrame:CGRectMake(screenW / 2 - deltaX, labelY, labelWidth, labelHeight)];
 // aTextField.inputView = [[CSNetAddressKeyboard alloc] initWithTextField:ipAddress keyboardLayout:INNetAddressKeyboardIPv4];
    ipAddress.placeholder = @"请输入IP地址";
    [ipAddress setBorderStyle:UITextBorderStyleRoundedRect];
    ipAddress.textAlignment=UITextAlignmentCenter;
    ipAddress.keyboardType = UIKeyboardTypeDecimalPad;
    ipAddress.tag = 1000;
    self.ipAddress = ipAddress.text;
  //  [self.view addSubview:ipAddress];
   // [ipAddress addTarget:self action:@selector(ipAddressInput) forControlEvents:UIControlEventTouchUpInside];
    self.operateButton.hidden=NO;
    [ipAddress setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ipAddress setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(screenW / 2 - deltaX, labelY + marginY, labelWidth, labelHeight)];
    name.placeholder = @"请输入名称";
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    name.textAlignment=UITextAlignmentCenter;
    [name setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [name setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    name.tag = 1001;
   // [self.view addSubview:name];
    UITextField *port = [[UITextField alloc]initWithFrame:CGRectMake(screenW / 2 - deltaX, labelY + marginY *2, labelWidth, labelHeight)];
    port.placeholder = @"请输入端口号";
    port.tag = 1002;
  //  [self.view addSubview:port];
    [port setBorderStyle:UITextBorderStyleRoundedRect];
    port.textAlignment=UITextAlignmentCenter;
    port.keyboardType = UIKeyboardTypeNumberPad;
    [port setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [port setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    UITextField *deviceID = [[UITextField alloc]initWithFrame:CGRectMake(screenW / 2 - deltaX, labelY + marginY * 3, labelWidth, labelHeight)];
    deviceID.placeholder = @"请输入设备号";
    deviceID.tag = 1003;
 //   [self.view addSubview:deviceID];
    [deviceID setBorderStyle:UITextBorderStyleRoundedRect];
    deviceID.textAlignment=UITextAlignmentCenter;
    deviceID.keyboardType = UIKeyboardTypeNumberPad;
    [deviceID setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [deviceID setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];*/
   /* CGFloat labelY = 100,marginY = 40;
    UIButton *loginRegister = [[UIButton alloc]initWithFrame:CGRectMake(30, labelY + marginY *4, screenW - 60, 50)];
    [loginRegister setTitle:@"更新一个Modbus连接配置" forState:UIControlStateNormal];
   // loginRegister.backgroundColor = [UIColor magentaColor];
  //  [self.view addSubview:loginRegister];
    [loginRegister addTarget:self action:@selector(connectModbus:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.operateButton.layer.borderWidth=1;
    self.operateButton.layer.borderColor=[UIColor magentaColor].CGColor;
    self.operateButton.layer.cornerRadius=loginRegister.frame.size.height*0.1;
   // [loginRegister setImage:[UIImage imageNamed:@"1run"] forState:UIControlStateNormal];
    [self.operateButton setBackgroundImage:[UIImage imageNamed:@"告警复位--常态"] forState:UIControlStateNormal];
    [self.operateButton setBackgroundImage:[UIImage imageNamed:@"告警-按下去的颜色值"] forState:UIControlStateHighlighted];
    
    
    [loginRegister setTitle:@"更新一个Modbus连接配置" forState:UIControlStateNormal];
    [loginRegister setTitle:@"已经保存，请重启app生效" forState:UIControlStateSelected];
    [loginRegister setTitleColor:[UIColor redColor] forState:UIControlStateSelected];*/
  //  [loginRegister setTitle:@"xxx" forState:UIControlStateHighlighted];
   // [loginRegister setImage:[UIImage imageNamed:@"publish-audio"] forState:UIControlStateSelected];
//conf = loginRegister;
  //  NSLog(@"mingziText%@",self.mingziText.text);
}
#pragma mark - 点击设置连接IP地址等参数后调用,这一版本不用了
-(void)connectModbus:(UIButton *)sender
{return;
 /*   if (!sender.selected) {
        [conf setTitle:@"更新一个Modbus连接配置" forState:UIControlStateNormal];
    } else {
        [conf setTitle:@"告警-按下去" forState:UIControlStateNormal];*/

  //  }
   // NSLog(@"helloworld");
   // GMLHighFrequencyListViewcontroller *highFrequencyList = [[GMLHighFrequencyListViewcontroller alloc]init];
    //[self.view prese:highFrequencyList animated:YES];
  /*  NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"123.plist"];
   // NSMutableArray *array = @[@"123", @"456", @"789"];
    //NSArray *array = @self.ipAddress, self.deviceName, [NSNumber numberWithInt:self.port]];
    NSArray *array = [[NSArray alloc] initWithObjects:self.ipAddress, self.deviceName, self.port, self.deviceID, nil];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:self.ipAddress];
    [array addObject:self.deviceName];
    [array addObject:[NSNumber numberWithInt:self.port]];*/
   /* [array writeToFile:fileName atomically:YES];*/
  /*  self.ipAddress = @"192.168.3.183";
    self.deviceName = @"1A1";
    //self.port=502;
   // self.deviceID=1;
    NSMutableArray *mutableArray=[NSMutableArray arrayWithObjects:self.ipAddress, self.deviceName, self.port, self.deviceID, nil];
    NSArray *array = [NSArray arrayWithArray:mutableArray];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:array forKey:@"gmlFight2017"];
    NSUserDefaults *user1 = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result=[NSMutableArray arrayWithArray:[user1 objectForKey:@"gmlFight2017"]];
   // NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
    NSLog(@"%@", result);*/
   // NSString *path=[[NSBundle mainBundle] bundlePath];
    //NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //NSString *path=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
   // NSString *path=NSTemporaryDirectory();
   // NSLog(@"%@",path);
  /*  UITextField *ipAddress=(UITextField *)[self.view viewWithTag:1000];
    UITextField *name=(UITextField *)[self.view viewWithTag:1001];
    UITextField *port=(UITextField *)[self.view viewWithTag:1002];
    UITextField *deviceID=(UITextField *)[self.view viewWithTag:1003];

    NSString *text=ipAddress.text;
    NSString *text1=name.text;
    NSString *text2=port.text;
    NSString *text3=deviceID.text;
    if (![self isValidatIP:text]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"你输入的IP地址不对" message:@"请重新填写正确的IP地址！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel clicked");
        }];
        [alert addAction:cancelAction];*/
   /*     UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
          //  NSLog(@"ok clicked");
          //  return ;
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        // [self.view addSubview:alert];
        return ;
    }
  //  NSLog(@"%@",text);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"connectConfigure.plist"];
    NSArray *array=[NSArray arrayWithObjects:text,text1,text2,text3, nil];
    [array writeToFile:fileName atomically:YES];
    
    sender.selected = !sender.selected;
*/
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
- (IBAction)saveDB:(UIButton *)sender {
 /*   NSString *mingzi=self.mingziText.text;
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
    }*/
  //  if (GMLUpdateOrAdd) {
        

  //  } else {
        

  //  }
 

    
}
/**
 *  增
 */
- (IBAction)detailsTap:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

/**
 *  删
 */
-(void)deleteData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
  //  NSLog(@"参数配置删除%@",path);
    sqlite3 *db;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
      //  NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
     //   NSLog(@"run sql failed:%s",error);
    }
    NSString *mingzi=self.mingziText.text;
    NSString *gml=[NSString stringWithFormat:@"delete from t_modbusConnectConfigure where mingzi='%@'      ",mingzi];
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
    //    NSLog(@"run sql failed:%s",error);
    }
    sqlite3_close(db);
}
/**
 *  查
 */
-(void)selectData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path=[path stringByAppendingPathComponent:@"mydb.sqlite"];
   // NSLog(@"参数配置查看%@",path);
    sqlite3 *db;
    sqlite3_stmt *stmt;
    int result = sqlite3_open([path UTF8String], &db);
    if (result != SQLITE_OK) {
        NSLog(@"open failed");
    }
    char *sql="CREATE TABLE if not exists t_modbusConnectConfigure ('mingzi' text(4,0) NOT NULL,'ipdizhi' text(15,0) NOT NULL,'zhuangtai' text NOT NULL,'duankouhao' integer NOT NULL,'shebeihao' integer NOT NULL,'IDNO' integer NOT NULL,PRIMARY KEY('IDNO'));";
    char *error;
    result=sqlite3_exec(db, sql, NULL, NULL, &error);
    if (result != SQLITE_OK) {
      //  NSLog(@"run sql failed:%s",error);
    }
    NSString *mingzi=self.mingziText.text;
    NSString *gml=[NSString stringWithFormat:@"select * from t_modbusConnectConfigure where mingzi='%@'",mingzi];
    result=sqlite3_exec(db, [gml UTF8String], NULL, NULL, &error);
    result=sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
        //    char * mingzi=(char *)sqlite3_column_text(stmt, 0);
         //   char *ipdizhi=(char *)sqlite3_column_text(stmt, 1);
      //      char *zhuangtai=(char *)sqlite3_column_text(stmt, 2);
     //       int duankouhao=sqlite3_column_int(stmt, 3);
         //   int shebeihao=sqlite3_column_int(stmt, 4);
      //      NSString *strmingzi=[NSString stringWithUTF8String:mingzi];
      //      NSString *stripdizhi=[NSString stringWithUTF8String:ipdizhi];
     //       NSString *strzhuangtai=[NSString stringWithUTF8String:zhuangtai];
       //     self.zhuangtaiText.text=strzhuangtai;
          //  NSLog(@"mingzi=%@,ipdizhi=%@,zhuangtai=%@,duankouhao=%d,shebeihao=%d",strmingzi,stripdizhi,strzhuangtai,duankouhao,shebeihao);
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
}
/**
 *  改
 */
@end
